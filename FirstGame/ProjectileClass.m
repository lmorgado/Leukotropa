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

- (int) getPowerDamage
{
    return self.power;
}

@end