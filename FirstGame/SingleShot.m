//
//  SingleShot.m
//  FirstGame
//
//  Created by Stefano Politi on 04/02/15.
//  Copyright (c) 2015 Jordan Rodrigues Rangel. All rights reserved.
//

#import "SingleShot.h"
#include "Algebra.h"
#include "CollisionCategories.h"

@implementation SingleShot

//Método de tiro.
- (void)shootEnemyIn:(CGPoint) direction withDuration:(NSTimeInterval) duration {
    
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
    
    SKAction *moveShootActionWithDone = [SKAction sequence:@[laserFireSoundAction, rotate, shootMoveAction, shootDoneAction]];
    
    [self runAction:moveShootActionWithDone];
    
    
}

@end
