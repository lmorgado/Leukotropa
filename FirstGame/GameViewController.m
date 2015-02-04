//
//  GameViewController.m
//  FirstGame
//
//  Created by Jordan Rodrigues Rangel on 1/28/15.
//  Copyright (c) 2015 Jordan Rodrigues Rangel. All rights reserved.
//

#import "GameViewController.h"
#import "ProjectileClass.h"
#import "GameScene.h"
#import "FirstScene.h"

@implementation GameViewController


- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    SKView * skView = (SKView *)self.view;
    
    if (!skView.scene) {
        
        skView.showsFPS = YES;
        skView.showsNodeCount = YES;
        
        SKScene * scene = [FirstScene sceneWithSize:skView.bounds.size];
        //FirstScene * scene = [[FirstScene alloc] initWithSize:skView.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        
        [skView presentScene:scene];
    }
}

@end