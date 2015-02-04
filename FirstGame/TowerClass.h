//
//  TowerClass.h
//  FirstGame
//
//  Created by Jordan Rodrigues Rangel on 1/28/15.
//  Copyright (c) 2015 Jordan Rodrigues Rangel. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface TowerClass : SKSpriteNode

@property (nonatomic) NSTimeInterval lastSpawnTimeInterval;

-(instancetype)initWithImageNamed:(NSString *)name;
-(NSString *)imageName;
-(float)getRange;
-(float)getDelay;

@end