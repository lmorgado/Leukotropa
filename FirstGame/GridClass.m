//
//  GridClass.m
//  FirstGame
//
//  Created by Jordan Rodrigues Rangel on 1/28/15.
//  Copyright (c) 2015 Jordan Rodrigues Rangel. All rights reserved.
//

#import "GridClass.h"

@interface GridClass()


@property(nonatomic) int i;
@property(nonatomic) int j;
@property(nonatomic) Terrain terraintype;
@property(nonatomic) BOOL isThereATowerPlaced;
@property(nonatomic) CGPoint center;
@property(nonatomic) CGSize size;

@end

@implementation GridClass

-(instancetype)initWithI: (int) i withJ:(int) j  ofTerrain:(Terrain) t withSize:(CGSize) size{
    
    if(self = [super init])
    {
        self.i = i;
        self.j = j;
        self.terraintype = t;
        self.isThereATowerPlaced = NO;
        self.size = size;
        self.position = CGPointMake((CGFloat)j*size.width, (CGFloat)i*size.height);
        self.center = CGPointMake(self.position.x + size.width/2.0f, self.position.y + size.height/2.0f);
        self.pathNode = nil;
    }
    
    return self;
}

- (CGPoint)gridCenter
{
    return self.center;
}

- (BOOL)placeTower
{
    BOOL theReturn = NO;
    
    if (self.terraintype == PLACEHOLDER && !self.isThereATowerPlaced) {
        self.isThereATowerPlaced = YES;
        theReturn = YES;
    }
    
    return theReturn;
    
}

- (Terrain)getGridCellTerrain
{
    return self.terraintype;
}

- (void)setTerrain:(Terrain)terrain
{
    self.terraintype = terrain;
}
@end