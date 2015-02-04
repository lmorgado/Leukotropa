//
//  GameScene.m
//  FirstGame
//
//  Created by Jordan Rodrigues Rangel on 1/28/15.
//  Copyright (c) 2015 Jordan Rodrigues Rangel. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "GameScene.h"
#import "ProjectileClass.h"
#import "GridClass.h"
#import "TowerClass.h"
#import "Enemy.h"
#include "Algebra.h"
#include "CollisionCategories.h"
#import "GameOverScene.h"
#import "RankingScene.h"


#define COLS 16
#define LINS 16
#define PATH_SIZE 11
#define MONSTERS_SIZE 5
#define TOWERS_SIZE 10
#define NUMBER_OF_LIVES 5

static NSString * const kTowerNodeName = @"movable";

@interface GameScene() <SKPhysicsContactDelegate>

{
    GridClass * matrix[LINS][COLS];
    GridClass * path[PATH_SIZE];
}

@property (nonatomic) float gridCellWidth;
@property (nonatomic) float gridCellHeight;
@property (nonatomic, strong) TowerClass *selectedNode;
@property (nonatomic) CGPoint originalSelectedNodePosition;
@property (nonatomic) NSMutableArray *monsters;
@property (nonatomic) NSTimeInterval lastSpawnTimeInterval;
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;
@property (nonatomic) int monstersRespawned;
@property (nonatomic) NSMutableArray * towers;
@property (nonatomic) int towersCreated;

//Propriedades do jogo
@property (nonatomic) int lives;
@property (nonatomic) BOOL playable;
@property (nonatomic) SKLabelNode *livesLabel;
@property (nonatomic) UIButton *roundButton;
@property (nonatomic) int currentRound;
@property (nonatomic) SKLabelNode *currentRoundLabel;
@property (nonatomic) int score;
@property (nonatomic) SKLabelNode *scoreLabel;


@property (nonatomic) int monstersOut;

@end

@implementation GameScene

-(id)initWithSize:(CGSize)size {
    
    if (self = [super initWithSize:size]) {
        
        // Imagem Background
        SKSpriteNode * background = [[SKSpriteNode alloc] initWithImageNamed:@"opçao_01.jpg"];
        background.position = CGPointMake(size.width/2.0f, size.height/2.0f);
        background.size = size;
        
        [self addChild:background];
        //FIM
        
        //Codigo do Grid
        self.gridCellHeight = size.height/LINS;
        self.gridCellWidth = size.width/COLS;
        
        //Caminho
        [self createPath:0];
        //FIM-Caminho
        
        //Menu
        [self creatMenu];
        //FIM-Menu
        
        //PLACEHOLDERS
        for(int i = 0; i < LINS; i++)
        {
            for(int j = 0; j < COLS; j++)
            {
                if(matrix[i][j] == nil)
                    matrix[i][j] = [[GridClass alloc] initWithI:i withJ:j ofTerrain:PLACEHOLDER withImageNamed:nil withSize:CGSizeMake(self.gridCellWidth, self.gridCellHeight)];
                
                [self addChild:matrix[i][j]];
            }
        }
        //FIM-PLACEHOLDERS
        
        //Criação de Torres
        NSArray *imageNames = @[@"Mons 10.png", @"Mons 2.png"];
        
        for(int i = 0; i < [imageNames count]; ++i) {
            
            
            NSString *imageName = [imageNames objectAtIndex:i];
            
            TowerClass *sprite = [[TowerClass alloc] initWithImageNamed:imageName];
            
            sprite.lastSpawnTimeInterval = 5;
            
            sprite.size = CGSizeMake(sprite.size.width/20.0f, sprite.size.height/20.0f);
            
            [sprite setName:kTowerNodeName];
            
            float offsetFraction = ((float)(i + 1)) / ([imageNames count] + 1);
            
            [sprite setPosition:CGPointMake(size.width - sprite.size.width/2.0f - 15.0f, (size.height*offsetFraction / 2))];
            
            [self addChild:sprite];
        }
        
        self.towers = [[NSMutableArray alloc] initWithCapacity:TOWERS_SIZE];
        self.towersCreated = 0;
        //FIM - Criação de Torres
        
        //Inicializa a física
        self.physicsWorld.gravity = CGVectorMake(0,0);
        self.physicsWorld.contactDelegate = self;
        //FIM - Inicializa a física
        
        
        //Inicializa as vidas do jogador.
        self.lives = NUMBER_OF_LIVES;
        CGPoint labelPosition = CGPointMake([matrix[LINS-1][COLS-2] gridCenter].x + self.gridCellWidth/2.0f,[matrix[LINS-1][COLS-1] gridCenter].y);
        self.livesLabel = [[SKLabelNode alloc] init];
        self.livesLabel.position = labelPosition;
        self.livesLabel.fontSize = 20.0f;
        self.livesLabel.text = [NSString stringWithFormat:@"Vidas: %d", self.lives];
        self.livesLabel.fontColor = [UIColor whiteColor];
        self.livesLabel.fontName = @"ChalkboardSE-Bold";
        [self addChild:self.livesLabel];
        //FIM
        
        //Botao de Rounds
        self.playable = NO;
        self.roundButton = [[UIButton alloc] initWithFrame:CGRectMake([matrix[0][5] gridCenter].x - (self.gridCellWidth/2), size.height - [matrix[0][6] gridCenter].y - (self.gridCellHeight/2), 2*self.gridCellWidth, self.gridCellHeight)];
        [self.roundButton setTitle:@"Começar Round" forState:UIControlStateNormal];
        self.roundButton.backgroundColor = [[UIColor alloc] initWithRed:0.9f green:0.2f blue:0.6f alpha:0.6];
        [self.roundButton addTarget:self action:@selector(startRound) forControlEvents:UIControlEventTouchUpInside];
        //FIM-Botão de Rounds
        
        //Label de Rounds
        self.currentRound = 0;
        self.currentRoundLabel = [[SKLabelNode alloc] init];
        self.currentRoundLabel.fontSize = 20.0f;
        self.currentRoundLabel.text = @"Nível: 1";
        self.currentRoundLabel.fontColor = [UIColor whiteColor];
        self.currentRoundLabel.fontName = @"ChalkboardSE-Bold";
        self.currentRoundLabel.position = CGPointMake(size.width/2.0f, [matrix[LINS-1][COLS-1] gridCenter].y);
        [self addChild:self.currentRoundLabel];
        //FIM-Label de Rounds
        
        //Label de Score
        self.score = 0;
        self.scoreLabel = [[SKLabelNode alloc] init];
        self.scoreLabel.fontSize = 20.0f;
        self.scoreLabel.text = [NSString stringWithFormat:@"Pontos: %d", self.score];
        self.scoreLabel.fontColor = [UIColor whiteColor];
        self.scoreLabel.fontName = @"ChalkboardSE-Bold";
        self.scoreLabel.position = CGPointMake(self.scoreLabel.frame.size.width/2, [matrix[LINS-1][COLS-1] gridCenter].y);
        [self addChild:self.scoreLabel];
        //FIM
        
    }
    
    return self;
}

-(void)didMoveToView:(SKView *)view
{
    [self.view addSubview: self.roundButton];
    //[self.view addSubview: self.rankingButton];
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    
    CGPoint positionInScene = [touch locationInNode:self];
    
    [self selectNodeForTouch:positionInScene];
}

- (void)selectNodeForTouch:(CGPoint)touchLocation {
    
    SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:touchLocation];
    
    
    if(![_selectedNode isEqual:touchedNode]) {
        
        [_selectedNode removeAllActions];
        
        [_selectedNode runAction:[SKAction rotateToAngle:0.0f duration:0.1]];
        
        _selectedNode = (TowerClass *) touchedNode;
        
        
        if([[touchedNode name] isEqualToString:kTowerNodeName]) {
            
            self.originalSelectedNodePosition = self.selectedNode.position;
            
            SKAction *sequence = [SKAction sequence:@[[SKAction rotateByAngle:degToRad(-4.0f) duration:0.1],
                                                      [SKAction rotateByAngle:0.0 duration:0.1],
                                                      [SKAction rotateByAngle:degToRad(4.0f) duration:0.1]]];
            [_selectedNode runAction:[SKAction repeatActionForever:sequence]];
        }
    }
    
}

float degToRad(float degree) {
    
    return degree / 180.0f * M_PI;
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    CGPoint position = [_selectedNode position];
    
    if([[_selectedNode name] isEqualToString:kTowerNodeName]) {
        
        int line = (int) position.y/self.gridCellHeight;
        int col = (int) position.x/self.gridCellWidth;
        
        if([matrix[line][col] placeTower])
        {
            CGPoint positionInGrid = matrix[line][col].position;
            CGSize sizeOfGrid = matrix[line][col].size;
            
            positionInGrid = CGPointMake(positionInGrid.x + sizeOfGrid.width/2.0f, positionInGrid.y + sizeOfGrid.height/2.0f);
            
            TowerClass * menuSprite = [[TowerClass alloc] initWithImageNamed:[_selectedNode imageName]];
            
            menuSprite.lastSpawnTimeInterval = 5;
            menuSprite.size = CGSizeMake(menuSprite.size.width/20.0f, menuSprite.size.height/20.0f);
            [menuSprite setName:kTowerNodeName];
            menuSprite.position = self.originalSelectedNodePosition;
            
            [self addChild:menuSprite];
            
            [_selectedNode setName:@"jaFoiColocadoNaGridCell"];
            [_selectedNode setPosition:positionInGrid];
            [self.towers addObject:_selectedNode];
            
            [_selectedNode removeAllActions];
            [_selectedNode runAction:[SKAction rotateToAngle:0.0f duration:0.1]];
            _selectedNode = nil;
            
            self.towersCreated++;
        }
        else
        {
            [_selectedNode setPosition:self.originalSelectedNodePosition];
        }
    }
}

- (void)panForTranslation:(CGPoint)translation {
    CGPoint position = [_selectedNode position];
    
    if([[_selectedNode name] isEqualToString:kTowerNodeName]) {
        [_selectedNode setPosition:CGPointMake(position.x + translation.x, position.y + translation.y)];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    
    CGPoint positionInScene = [touch locationInNode:self];
    
    CGPoint previousPosition = [touch previousLocationInNode:self];
    
    CGPoint translation = CGPointMake(positionInScene.x - previousPosition.x, positionInScene.y - previousPosition.y);
    
    [self panForTranslation:translation];
}

- (void)updateWithTimeSinceLastUpdate:(CFTimeInterval)timeSinceLast{
    
    if(self.monstersOut < [self.monsters count])
    {
        //Respawn
        self.lastSpawnTimeInterval += timeSinceLast;
        
        if(self.lastSpawnTimeInterval > 0.5  && self.playable && self.monstersRespawned < [self.monsters count]){
            self.lastSpawnTimeInterval = 0;
        
            //Cria ponteiro pro monstro.
            Enemy * enemy = self.monsters[self.monstersRespawned];
            self.monstersRespawned ++;
        
            [self addChild:enemy];
        
            //Cria o caminho a ser percorrido pelo monstro.
            float pathLength = 0.0;
        
            CGMutablePathRef actionPath = CGPathCreateMutable();
            CGPathMoveToPoint(actionPath, NULL, enemy.position.x, enemy.position.y);
        
            for(int i=0;i<PATH_SIZE;i++)
            {
                CGPathAddLineToPoint(actionPath, NULL, [path[i] gridCenter].x, [path[i] gridCenter].y);
                if(i < (PATH_SIZE-1))
                    pathLength += rwLength(rwSub([path[i+1] gridCenter], [path[i] gridCenter]));
            }
        
            pathLength += self.gridCellWidth/2.0f + enemy.size.width/2.0f;
            CGPathAddLineToPoint(actionPath, NULL, [path[PATH_SIZE-1] gridCenter].x + self.gridCellWidth/2.0f + enemy.size.width/2.0f, [path[PATH_SIZE-1] gridCenter].y);
        
            //Envia o caminho a ser percorrido para o monstro.
            [enemy moveTo:actionPath pathLength:pathLength gameScene:self];
        
        }
        
        [self towerMonitoringwithTimeSinceLastUpdate: timeSinceLast];
    }
    else
    {
        self.playable = NO;
        self.roundButton.hidden = NO;
    }

}

- (void) towerMonitoringwithTimeSinceLastUpdate: (CFTimeInterval)timeSinceLast
{
    //Monitoramento de cada torre.
    for(TowerClass * tower in self.towers)
    {
        tower.lastSpawnTimeInterval += timeSinceLast;
        
        //Se ja deu o tempo de intervalo entre tiros.
        if(tower.lastSpawnTimeInterval > [tower getDelay])
            //Para cada inimigo.
            for(Enemy * enemy in self.monsters)
            {
                if(![enemy getIsActive])
                    continue;
                
                BOOL didShoot = NO;
                
                tower.lastSpawnTimeInterval = 0;
                
                
                //Calcula a distancia da torre ate o inimigo.
                CGPoint direction = rwSub(enemy.position, tower.position);
                float distance = rwLength(direction);
                
                //Se o inimigo está dentro do alcance da torre.
                if(distance <= [tower getRange] )
                {
                    
                    ProjectileClass * projectile = [[ProjectileClass alloc] initWithImageNamed:@"laserShot.png" inPosition:tower.position powerDamage:30];
                    
                    SKAction * removeFromArray = [SKAction customActionWithDuration:1.0f actionBlock:^(SKNode *node, CGFloat elapsedTime) {
                        [self.towers removeObject:projectile];
                    }];
                    
                    didShoot = YES;
                    [self addChild:projectile];
                    
                    [projectile shootEnemyIn:direction withDuration:1.0f andUseAction:removeFromArray];
                }
                
                if(didShoot)
                    break;
            }
    }
}

- (void)update:(NSTimeInterval)currentTime{

    //Calcula o tempo desde o ultimo update.
    CFTimeInterval timeSinceLast = currentTime - self.lastUpdateTimeInterval;
    self.lastUpdateTimeInterval = currentTime;
    
    //Teste de erro
    if(timeSinceLast > 1){
        timeSinceLast = 1.0f/60.0f;
        self.lastUpdateTimeInterval = currentTime;
    }
    
    //Chama o update passando o intervalo de tempo do ultimo update.
    [self updateWithTimeSinceLastUpdate: timeSinceLast];
}

- (void)didBeginContact:(SKPhysicsContact *)contact
{
    SKPhysicsBody *firstBody, *secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask)
    {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    else
    {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    

    if ((firstBody.categoryBitMask & projectileCategory) != 0 &&
        (secondBody.categoryBitMask & monsterCategory) != 0)
    {
        [self projectile:(ProjectileClass *) firstBody.node didCollideWithMonster:(Enemy *) secondBody.node];
    }
}

- (void)projectile:(ProjectileClass *)projectile didCollideWithMonster:(Enemy *)monster {
   
    [projectile removeFromParent];
    
    if([monster causeDamage:[projectile getPowerDamage]])
    {
        self.monstersOut++;
        self.score++;
        self.scoreLabel.text = [NSString stringWithFormat:@"Pontos: %d", self.score];
        self.scoreLabel.position = CGPointMake(self.scoreLabel.frame.size.width/2, [matrix[LINS-1][COLS-1] gridCenter].y);
        [monster removeFromParent];
    }
}

- (void) removeLife
{
    self.monstersOut++;
    self.lives--;
    self.livesLabel.text = [NSString stringWithFormat:@"Vidas: %d", self.lives];
    
    if(self.lives == 0)
    {
        SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
        SKScene * gameOverScene = [[GameOverScene alloc] initWithSize:self.size won:NO score:self.score];
        
        [self removeViewsFromSuperView];
        
        [self.view presentScene:gameOverScene transition: reveal];
    }
}

-(void)removeViewsFromSuperView
{
    if(self.roundButton)
    {
        [self.roundButton removeFromSuperview];
        self.roundButton = nil;
    }
}

- (void) startRound
{
    self.roundButton.hidden = YES;
    self.currentRound++;
    self.monstersOut = 0;
    self.currentRoundLabel.text = [NSString stringWithFormat:@"Nível: %d", self.currentRound];
    
    self.lastSpawnTimeInterval = 5;
    
    //Calcula a quantidade de monstros.
    int monstersAmount = MONSTERS_SIZE + 2 * self.currentRound;
    
    //Recria Vetor de Monstros
    self.monsters = [[NSMutableArray alloc] initWithCapacity:monstersAmount];
    self.monstersRespawned = 0;
    
    for(int i=0;i<monstersAmount;i++){
        
        //Cria o monstro
        GridClass * firstGrid = path[0];
        Enemy * enemy = [[Enemy alloc] initWithSpeed:(10.0f + self.currentRound/3) withPosition:[firstGrid gridCenter] withLife:50 image:@"Mons 6.png" andDamage:1];
        
        enemy.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:enemy.size];
        enemy.physicsBody.dynamic = YES;
        enemy.physicsBody.categoryBitMask = monsterCategory;
        enemy.physicsBody.contactTestBitMask = projectileCategory;
        enemy.physicsBody.collisionBitMask = 0;
        
        //Cria o monstro no Vetor de Monstros
        [self.monsters addObject:enemy];
    }
    self.playable = YES;

}

-(void)createPath:(int)level
{
    NSString * path = [[NSBundle mainBundle] pathForResource:@"sceneConfig" ofType:@".txt"];
    
    FILE* sceneConfig = fopen([path UTF8String], "r");
    char strTemp[100];
    char levelString[10];
    
    sprintf(levelString, "#level-%d#", level);
    
    if(!sceneConfig)
    {
        NSLog(@"Error - couldn't open sceneConfig.txt");
        exit(-1);
    }
    
    fscanf(sceneConfig, " %[^\n]", strTemp);
    
    while(strcmp(strTemp, levelString))
    {
        fscanf(sceneConfig, " %[^\n]", strTemp);
    }
    
    int index;
    
    while(fscanf(sceneConfig, "%d", &index) == 1)
    {
        int lin = index / COLS;
        int col = index % LINS;
        
        matrix[lin][col] = [[GridClass alloc] initWithI:lin withJ:col ofTerrain:PATH withImageNamed:nil withSize:CGSizeMake(self.gridCellWidth, self.gridCellHeight)];
    }
    
    fscanf(sceneConfig, " %[^\n]", strTemp);
    
    printf("%s",strTemp);
    
    fclose(sceneConfig);
}

-(void) creatMenu
{
    for(int lin = 0; lin < 2; lin++)
    {
        for(int col = 0; col < COLS; col++)
        {
            matrix[lin][col] = [[GridClass alloc] initWithI:lin withJ:col ofTerrain:NIL withImageNamed:nil withSize:CGSizeMake(self.gridCellWidth, self.gridCellHeight)];
        }
    }
    
    for(int lin = LINS-2; lin < LINS; lin++)
    {
        for(int col = 0; col < COLS; col++)
        {
            matrix[lin][col] = [[GridClass alloc] initWithI:lin withJ:col ofTerrain:NIL withImageNamed:nil withSize:CGSizeMake(self.gridCellWidth, self.gridCellHeight)];
        }
    }
}


@end