//
//  Red.h
//  FirstGame
//
//  Created by Stefano Politi on 08/02/15.
//  Copyright (c) 2015 Jordan Rodrigues Rangel. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "GameScene.h"

@interface Red : SKSpriteNode

- (instancetype) initWithPosition: (CGPoint) position;
- (void) moveTo: (CGMutablePathRef)actionPath pathLength: (float)distance gameScene: (GameScene*)scene;
-(void) killRed;


@end
