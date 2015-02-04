//
//  ProjectileClass.h
//  FirstGame
//
//  Created by Jordan Rodrigues Rangel on 1/28/15.
//  Copyright (c) 2015 Jordan Rodrigues Rangel. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>



@interface ProjectileClass : SKSpriteNode

- (instancetype)initWithImageNamed:(NSString*) imgName inPosition:(CGPoint) position powerDamage:(int) power;
- (int) getPowerDamage;

@end