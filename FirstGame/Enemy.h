

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

- (instancetype) initWithSpeed:(float) speed withPosition:(CGPoint) position withLife: (int)life image:(NSString*)imgName andDamage:(int)damage;

- (void) moveTo:(CGMutablePathRef) actionPath pathLength:(float)distance gameScene:(GameScene*) scene;

- (float) getSpeed;

- (BOOL) causeDamage:(int)damage;

- (BOOL) getIsActive;

@end
