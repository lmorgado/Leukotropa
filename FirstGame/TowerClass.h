//
//  TowerClass.h
//  FirstGame
//
//  Created by Jordan Rodrigues Rangel on 1/28/15.
//  Copyright (c) 2015 Jordan Rodrigues Rangel. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>


typedef enum {
    
    INDIANTOWER,
    SPACETOWER,
    BOMBTOWER,
    FIRETOWER,
    HERO,
    NUMOFTOWERTYPES
} TypeOfTower;


@interface TowerClass : SKSpriteNode

@property (nonatomic) NSTimeInterval lastSpawnTimeInterval;

-(instancetype)initWithType: (TypeOfTower) type;
-(NSString *)imageName;
-(float)getRange;
-(float)getDelay;
-(TypeOfTower)getType;
- (int) getCost;

@end