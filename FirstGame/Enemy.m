
#import "Enemy.h"
#include "Algebra.h"

@interface Enemy()

//Movimento do inimigo
@property (nonatomic) CGPoint destiny;

//Velocidade do inimigo
@property (nonatomic) float speed;

//Vida do inimigo "Health Power"
@property (nonatomic) int hp;

//Imagem
@property (nonatomic) NSString *imgName;

//Dano causado pelo inimigo
@property (nonatomic) int damage;

//Inimigo ativo
@property (nonatomic) BOOL isActive;

//Score desse tipo de inimigo
@property (nonatomic) int givenScore;

@end


@implementation Enemy


// METODO CONSTRUTOR DO INIMIGO
- (instancetype) initWithPosition: (CGPoint)position withTypeEnemy: (ENEMY_TYPE)enemyType
{
    switch (enemyType) {
        case LEVEL_00:
            self.imgName = @"enemy_00.png";
            break;
            
        case LEVEL_01:
            self.imgName = @"enemy_01.png";
            break;
            
        case LEVEL_02:
            self.imgName = @"enemy_02.png";
            break;
            
        case LEVEL_03:
            self.imgName = @"enemy_03.png";
            break;
    }
    
    if(self = [super initWithImageNamed:self.imgName])
    {
        CGSize size = self.size;
        
        self.size = CGSizeMake(size.width/40.0f, size.height/40.0f);
        
        self.position = CGPointMake(-self.size.width/2.0f, position.y);
        
        self.isActive = YES;
        
        switch (enemyType) {
            
            case LEVEL_00 :
                self.givenScore = 1;
                self.hp = 50;
                self.speed = 8.0f;
                self.damage = 1;
                break;
             
            case LEVEL_01 :
                self.givenScore = 3;
                self.hp = 100;
                self.speed = 10.0f;
                self.damage = 2;
                break;

            case LEVEL_02 :
                self.givenScore = 5;
                self.hp = 150;
                self.speed = 12.0f;
                self.damage = 3;
                break;
                
            case LEVEL_03 :
                self.givenScore = 50;
                self.hp = 2500;
                self.speed = 2.5f;
                self.damage = 9999999;
                break;
        }
        
    }
    
    return self;
}
// FIM

// METODO INIMIGO PERCORRE TODO CAMINHO NA SCENE, MORRENDO AO FIM DO CAMINHO
- (void) moveTo: (CGMutablePathRef)actionPath pathLength: (float)distance gameScene: (GameScene*)scene
{
    
    SKAction *followline = [SKAction followPath:actionPath asOffset:NO orientToPath:NO duration:distance/self.speed];
    
    SKAction *removeLife = [SKAction runBlock:^{
        [scene removeLife:self.damage];
        self.isActive = NO;
    }];
    
    SKAction *finalAction = [SKAction sequence: @[followline, removeLife, [SKAction removeFromParent]]];
    
    [self runAction : finalAction];
}
// FIM

// METODO OBTEM VELOCIDADE
- (float) getSpeed
{
    
    return self.speed;

}
// FIM

// METODO PARA VERIFICAR DANO CAUSADO AO INIMIGO
- (BOOL) causeDamage: (int)damage
{
    self.hp -= damage;
    
    if(self.hp <= 0) {
        
        self.isActive = NO;
      
        return YES;
    }
    return NO;
}
// FIM

// METODO OBTEM STATUS DO INIMIGO: VIVO OU MORTO
- (BOOL) getIsActive
{
    return self.isActive;
}
// FIM

// Retorna a quantidade de score dada por este monstro
- (int) monsterScore
{
    return self.givenScore;
}
// FIM

@end