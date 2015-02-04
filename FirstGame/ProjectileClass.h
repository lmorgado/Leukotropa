//
//  ProjectileClass.h
//  FirstGame
//
//  Created by Jordan Rodrigues Rangel on 1/28/15.
//  Copyright (c) 2015 Jordan Rodrigues Rangel. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

//typedef enum {
//    
//    STRONG = 4,
//    MEDIUM = 2,
//    WEAK   = 0
//    
//} power;



@interface ProjectileClass : SKSpriteNode

- (instancetype)initWithImageNamed:(NSString*) imgName inPosition:(CGPoint) position powerDamage:(int) power;
- (void)shootEnemyIn:(CGPoint) direction withDuration:(NSTimeInterval) duration andUseAction:(SKAction*) action;
- (int) getPowerDamage;

@end