//
//  GameOverScene.m
//  FirstGame
//
//  Created by Stefano Politi on 28/01/15.
//  Copyright (c) 2015 Jordan Rodrigues Rangel. All rights reserved.
//


#import "GameOverScene.h"
#import "GameScene.h"
#import "RankingScene.h"

@interface GameOverScene()

@property (nonatomic) UIButton * nextGameButton;
@property (nonatomic) UIButton * sendScoreButton;
@property (nonatomic) int score;
@property (nonatomic) UITextField * textBox;
@property (nonatomic) UIButton * rankingButton;

@end

@implementation GameOverScene

-(id)initWithSize:(CGSize)size won:(BOOL)won score:(int)score{
    if (self = [super initWithSize:size]) {
        
        self.score = score;
        //Background
        self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        
        //Mensagem na Tela
        NSString * message;
        if (won) {
            message = @"Parabéns! Você ganhou!";
        } else {
            message = @"Você perdeu! :[";
        }
        
        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        label.text = message;
        label.fontSize = 40;
        label.fontColor = [SKColor blackColor];
        label.position = CGPointMake(self.size.width/2, self.size.height/2);
        [self addChild:label];
        //FIM
    }
    
    //Botao de Novo Jogo
    self.nextGameButton = [[UIButton alloc] initWithFrame:CGRectMake(size.width/2 - 100 , size.height-15, 200, 15)];
    [self.nextGameButton setTitle:@"Jogar de novo" forState:UIControlStateNormal];
    self.nextGameButton.backgroundColor = [[UIColor alloc] initWithRed:0.9f green:0.2f blue:0.6f alpha:0.6];
    [self.nextGameButton addTarget:self action:@selector(startNewGame) forControlEvents:UIControlEventTouchUpInside];
    self.nextGameButton.hidden = NO;
    //FIM
    
    //Botao de Pontuacao
    self.sendScoreButton = [[UIButton alloc] initWithFrame:CGRectMake(size.width/2 - 100 , size.height-40, 200, 15)];
    [self.sendScoreButton setTitle:@"Enviar Pontuação" forState:UIControlStateNormal];
    self.sendScoreButton.backgroundColor = [[UIColor alloc] initWithRed:0.9f green:0.2f blue:0.6f alpha:0.6];
    [self.sendScoreButton addTarget:self action:@selector(sendScore) forControlEvents:UIControlEventTouchUpInside];
    self.sendScoreButton.hidden = NO;
    //FIM
    
    //Caixa de Texto Nome do Usuario.
    self.textBox = [[UITextField alloc] initWithFrame:CGRectMake(size.width/2 - 100, size.height - 65, 200, 15)];
    self.textBox.backgroundColor = [[UIColor alloc] initWithRed:0.9f green:0.2f blue:0.6f alpha:0.6];
    self.textBox.textColor = [UIColor whiteColor];
    
    //FIM
    
    //Botao de Ranking
    self.rankingButton = [[UIButton alloc] initWithFrame:CGRectMake(10.0f, size.height - 60.0f, 100.0f, 50.0f)];
    [self.rankingButton setTitle:@"Ver Ranking" forState:UIControlStateNormal];
    self.rankingButton.backgroundColor = [[UIColor alloc] initWithRed:0.9f green:0.2f blue:0.6f alpha:0.6];
    [self.rankingButton addTarget:self action:@selector(openRanking) forControlEvents:UIControlEventTouchUpInside];
    //FIM
    
    
    return self;
}

//-(void) sendScore
//{
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"ranking" ofType:@"plist"];
//    // Create the new dictionary that will be inserted into the plist.
//    NSMutableDictionary *scoreDictionary = [NSMutableDictionary dictionary];
//    [scoreDictionary setValue:self.textBox.text forKey:@"Nome"];
//    [scoreDictionary setValue:[NSString stringWithFormat:@"%d", self.score] forKey:@"Score"];
//    // Open the plist from the filesystem.
//    NSMutableArray *plist = [NSMutableArray arrayWithContentsOfFile:path];
//    if (plist == nil) plist = [NSMutableArray array];
//    [plist addObject:scoreDictionary];
//    [plist writeToFile:path atomically:YES];
//    NSLog(@"%@", plist);
//    
//    //Apagar Campos de envio de pontos
//    self.textBox.hidden = YES;
//    self.sendScoreButton.hidden = YES;
//}

-(void)sendScore
{
    if(!self.textBox.text || [self.textBox.text length] == 0)
        return;
    
    NSNumber * score = [NSNumber numberWithInt:self.score];
    NSString * name = self.textBox.text;
    
    NSString * rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString * plistPath = [rootPath stringByAppendingPathComponent:@"Ranking.plist"];
    
    NSMutableDictionary * mutDir = [[NSMutableDictionary alloc] initWithObjectsAndKeys:name, @"Name", score, @"Score", nil];
    
    NSMutableArray * plist = [[NSMutableArray alloc] initWithContentsOfFile: plistPath];
    
    if(plist)
        [plist addObject:mutDir];
    else
        plist = [[NSMutableArray alloc] initWithObjects:mutDir, nil];
    
    [plist writeToFile:plistPath atomically:YES];
    
    if(self.sendScoreButton)
    {
        [self.sendScoreButton removeFromSuperview];
        self.sendScoreButton = nil;
    }
    
    if(self.textBox)
    {
        [self.textBox removeFromSuperview];
        self.textBox = nil;
    }
}

-(void)didMoveToView:(SKView *)view
{
    [self.view addSubview:self.nextGameButton];
    [self.view addSubview:self.sendScoreButton];
    [self.view addSubview:self.textBox];
    [self.view addSubview: self.rankingButton];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    [self.view endEditing:YES];

}
-(void) startNewGame
{
    SKAction *nextGameAction = [SKAction runBlock:^{
        SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
        SKScene * myScene = [[GameScene alloc] initWithSize:self.size];
        [self.view presentScene:myScene transition: reveal];
    }];
    
//    self.nextGameButton.hidden = YES;
//    self.sendScoreButton.hidden = YES;
//    self.textBox.hidden = YES;
    
    [self removeButtons];
    
    [self runAction:nextGameAction];
}

-(void)removeButtons
{
    if(self.sendScoreButton)
    {
        [self.sendScoreButton removeFromSuperview];
        self.sendScoreButton = nil;
    }
    
    if(self.textBox)
    {
        [self.textBox removeFromSuperview];
        self.textBox = nil;
    }
    
    if(self.nextGameButton)
    {
        [self.nextGameButton removeFromSuperview];
        self.nextGameButton = nil;
    }
    
    if(self.rankingButton)
    {
        [self.rankingButton removeFromSuperview];
        self.rankingButton = nil;
    }
}

-(void) openRanking
{
    SKScene * rankingScene = [[RankingScene alloc] initWithSize:self.size];
    [self removeButtons];
    [self.view presentScene:rankingScene];
}

@end
