//
//  Enemy.h
//  FirstGame
//
//  Created by Jordan Rodrigues Rangel on 1/28/15.
//  Copyright (c) 2015 Jordan Rodrigues Rangel. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "GameScene.h"

@interface Enemy : SKSpriteNode

- (instancetype) initWithSpeed:(float) speed withPosition:(CGPoint) position withLife: (int)life image:(NSString*)imgName andDamage:(int)damage;

-(void) moveTo:(CGMutablePathRef) actionPath pathLength:(float)distance gameScene:(GameScene*) scene;

-(float) getSpeed;

-(BOOL) causeDamage:(int) damage;

-(BOOL) getIsActive;

@end
