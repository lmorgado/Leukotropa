//
//  GameOverScene.h
//  FirstGame
//
//  Created by Stefano Politi on 28/01/15.
//  Copyright (c) 2015 Jordan Rodrigues Rangel. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface GameOverScene : SKScene

-(id)initWithSize:(CGSize)size won:(BOOL)won score:(int)score;

@end
