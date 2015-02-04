//
//  ProjectileClass.m
//  FirstGame
//
//  Created by Jordan Rodrigues Rangel on 1/28/15.
//  Copyright (c) 2015 Jordan Rodrigues Rangel. All rights reserved.
//

#import "ProjectileClass.h"
#include "Algebra.h"
#include "CollisionCategories.h"

@interface ProjectileClass ()

@property (nonatomic) int power;

@end

@implementation ProjectileClass


- (instancetype)initWithImageNamed:(NSString*) imgName inPosition:(CGPoint) position powerDamage:(int) power
{
    
    if (self = [super initWithImageNamed: imgName]) {
        self.position = position;
        self.power = power;
        
        CGSize size = self.size;
        self.size = CGSizeMake(size.width/9.0f, size.height/9.0f);
    }
    
    return self;
    
}

- (void)shootEnemyIn:(CGPoint) direction withDuration:(NSTimeInterval) duration andUseAction:(SKAction*) action {
    
    direction = rwNormalize(direction);
    direction = rwMult(direction, 1000.0f);
    
    self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.size.width/2];
    self.physicsBody.dynamic = YES;
    self.physicsBody.categoryBitMask = projectileCategory;
    self.physicsBody.contactTestBitMask = monsterCategory;
    self.physicsBody.collisionBitMask = 0;
    self.physicsBody.usesPreciseCollisionDetection = YES;
    
    SKAction *laserFireSoundAction = [SKAction playSoundFileNamed:@"laserSound.mp3" waitForCompletion:NO];
    SKAction *shootMoveAction = [SKAction moveTo:direction duration:duration];
    SKAction *rotate = [SKAction rotateToAngle:rwRotation(direction) duration:0.0001];
    
    // Define a done action using a block that hides the laser when it hits the right edge
    SKAction *shootDoneAction = [SKAction removeFromParent];
    
    SKAction *moveShootActionWithDone = [SKAction sequence:@[laserFireSoundAction, rotate, shootMoveAction, action, shootDoneAction]];
    
    [self runAction:moveShootActionWithDone];
    
    
}

- (int) getPowerDamage
{
    return self.power;
}

@end