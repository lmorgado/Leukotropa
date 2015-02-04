//
//  TowerClass.m
//  FirstGame
//
//  Created by Jordan Rodrigues Rangel on 1/28/15.
//  Copyright (c) 2015 Jordan Rodrigues Rangel. All rights reserved.
//

#import "TowerClass.h"

@interface TowerClass()

@property (nonatomic) float range;
@property (nonatomic) float delay;
@property (nonatomic) BOOL isActive;
@property (nonatomic) NSString * imgName;

@end

@implementation TowerClass


-(instancetype)initWithImageNamed:(NSString *)name
{
    if(self = [super initWithImageNamed:name])
    {
        self.range = 100.0f;
        self.delay = 0.5f;
        self.isActive = NO;
        self.imgName = name;
        self.lastSpawnTimeInterval = 5.0f;
    }
    
    return self;
}

-(NSString *)imageName
{
    return self.imgName;
}

-(float)getRange
{
    return self.range;
}

-(float)getDelay
{
    return self.delay;
}

@end