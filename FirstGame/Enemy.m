
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

@end


@implementation Enemy


// METODO CONSTRUTOR DO INIMIGO
- (instancetype) initWithPosition: (CGPoint)position withTypeEnemy: (ENEMY_TYPE)enemyType
{
    
    if(self = [super initWithImageNamed:imgName])
    {
        CGSize size = self.size;
        
        self.size = CGSizeMake(size.width/20.0f, size.height/20.0f);
        
        self.position = CGPointMake(-self.size.width/2.0f, position.y);
        
        self.isActive = YES;
        
        
        switch (enemyType) {
            
            case LEVEL_00 :
                
                self.imgName = @"enemy_00.jpg";
                
                self.hp = 50;
                
                self.speed = 1.0f;
                
                sefl.damage = 1;
                
                break;
             
            case LEVEL_01 :
                
                self.imgName = @"enemy_01.jpg";
                
                self.hp = 100;
                
                self.speed = 1.5f;
                
                sefl.damage = 1;
                
                break;

                
            case LEVEL_02 :
                
                self.imgName = @"enemy_02.jpg";
                
                self.hp = 150;
                
                self.speed = 2.0f;
                
                sefl.damage = 2;
                
                break;
                
                
            case LEVEL_03 :
                
                self.imgName = @"enemy_03.jpg";
                
                self.hp = 180;
                
                self.speed = 3.0f;
                
                sefl.damage = 2;
                
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
        [scene removeLife];
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
    self.life -= damage;
    
    if(self.life <= 0) {
        
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



@end