

#import <SpriteKit/SpriteKit.h>
#import "GameScene.h"


typedef enum {

    LEVEL_00 = 0,
    
    LEVEL_01 = 1,
    
    LEVEL_02 = 2,
    
    LEVEL_03 = 3

} ENEMY_TYPE;

// withLife: (int)life image: (NSString*)imgName andDamage: (int)damage

@interface Enemy : SKSpriteNode

- (instancetype) initWithPosition: (CGPoint)position withTypeEnemy: (ENEMY_TYPE)enemyType;

- (void) moveTo:(CGMutablePathRef) actionPath pathLength:(float)distance gameScene:(GameScene*) scene;

- (float) getSpeed;

- (BOOL) causeDamage:(int)damage;

- (BOOL) getIsActive;

- (int) monsterScore;

@end
