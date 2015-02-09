//
//  GridClass.h
//  FirstGame
//
//  Created by Jordan Rodrigues Rangel on 1/28/15.
//  Copyright (c) 2015 Jordan Rodrigues Rangel. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef enum {
    
    PATHENEMY,
    PATHRED,
    PATHBOTH,
    NIL,
    PLACEHOLDER,
    MENU,
    AMOUNTOFTERRAINS
    
} Terrain;




@interface GridClass : SKSpriteNode

-(instancetype)initWithI: (int) i withJ:(int) j  ofTerrain:(Terrain) t withImageNamed:(NSString*) imgName withSize:(CGSize) size;
- (Terrain)getGridCellTerrain;
- (BOOL)placeTower;
- (CGPoint)gridCenter;
- (void)setTerrain:(Terrain)terrain;

@end