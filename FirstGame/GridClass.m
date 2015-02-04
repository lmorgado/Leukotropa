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

@end

@implementation GridClass

-(instancetype)initWithI: (int) i withJ:(int) j  ofTerrain:(Terrain) t withImageNamed:(NSString*) imgName withSize:(CGSize) size{
    
    if(imgName == nil)
    {
        // self = [super initWithColor:[[UIColor alloc] initWithRed:i/8.0f green:j/8.0f blue:arc4random_uniform(64)/64.0f alpha:0.5f] size:size];
        if(t == NIL || t == PLACEHOLDER || t == MENU)
            self = [super initWithColor:[[UIColor alloc] initWithRed:0.0f green:0.0f blue:0.0f alpha:0.001f] size:size];
        else
            self = [super initWithColor:[[UIColor alloc] initWithRed:i/8.0f green:j/8.0f blue:arc4random_uniform(64)/64.0f alpha:0.5f] size:size];
    }
    else
        self = [super initWithImageNamed:imgName];
    
    if(self)
    {
        self.i = i;
        self.j = j;
        self.terraintype = t;
        self.isThereATowerPlaced = NO;
        self.size = size;
        self.anchorPoint = CGPointZero;
        self.position = CGPointMake((CGFloat)j*size.width, (CGFloat)i*size.height);
        self.center = CGPointMake(self.position.x + size.width/2.0f, self.position.y + size.height/2.0f);
        
        //        SKSpriteNode * centerSquare = [SKSpriteNode spriteNodeWithColor:[UIColor redColor] size:CGSizeMake(10.0f, 10.0f)];
        //        centerSquare.position = self.center;
        //        [self addChild:centerSquare];
        
        //        SKLabelNode * label = [[SKLabelNode alloc] init];
        //        label.fontSize = 15.0f;
        //        label.text = [NSString stringWithFormat:@"%d, %d", self.i, self.j];
        //        label.fontColor = [UIColor whiteColor];
        //        [self addChild:label];
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