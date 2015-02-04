//
//  SingleShot.h
//  FirstGame
//
//  Created by Stefano Politi on 04/02/15.
//  Copyright (c) 2015 Jordan Rodrigues Rangel. All rights reserved.
//

#import "ProjectileClass.h"

@interface SingleShot : ProjectileClass

- (void)shootEnemyIn:(CGPoint) direction withDuration:(NSTimeInterval) duration;

@end
