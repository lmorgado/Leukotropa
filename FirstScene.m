//
//  FirstScene.m
//  FirstGame
//
//  Created by Stefano Politi on 29/01/15.
//  Copyright (c) 2015 Jordan Rodrigues Rangel. All rights reserved.
//

#import "FirstScene.h"
#import "GameScene.h"
@import AVFoundation;

@interface FirstScene()


@property (nonatomic) UIButton * startButton;
@property (nonatomic) AVAudioPlayer * backgroundMusicPlayer;

@end


@implementation FirstScene

-(id)initWithSize:(CGSize)size {
    
    self = [super initWithSize:size];
    
    // Imagem Background
    SKSpriteNode * background = [[SKSpriteNode alloc] initWithImageNamed:@"tela.png"];
    background.position = CGPointMake(size.width/2.0f, size.height/2.0f);
    background.size = size;
    
    if(background == nil)
    NSLog(@"eh nil");
    else
        NSLog(@"nao eh nil");
    
    [self addChild:background];
    //FIM - Imagem Background
    
    //Botao Jogar
    self.startButton = [[UIButton alloc] initWithFrame:CGRectMake(size.width - 200.0f, size.height - 100.0f, 100.0f, 75.0f)];
    self.startButton.backgroundColor = [[UIColor alloc] initWithRed:0.9f green:0.2f blue:0.6f alpha:0.6];
    [self.startButton setTitle:@"Jogar" forState:UIControlStateNormal];
    [self.startButton addTarget:self action:@selector(goNextScreen) forControlEvents:UIControlEventTouchUpInside];
    //FIM - Botão Jogar
    
    
    //Som
    NSError *error;
    NSURL * backgroundMusicURL = [[NSBundle mainBundle] URLForResource:@"Blackmoor Colossus (No Vocals)" withExtension:@"mp3"];
    self.backgroundMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:&error];
    self.backgroundMusicPlayer.numberOfLoops = -1;
    [self.backgroundMusicPlayer prepareToPlay];
    [self.backgroundMusicPlayer play];
    //FIM - Som
    
    return self;
}

-(void)didMoveToView:(SKView *)view
{
    [self.view addSubview:self.startButton];
}

-(void)goNextScreen
{
    self.startButton.hidden = YES;
    SKAction *nextGameAction = [SKAction runBlock:^{
        SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
        SKScene * myScene = [[GameScene alloc] initWithSize:self.size];
        [self.view presentScene:myScene transition: reveal];
    }];
    
    [self runAction:nextGameAction];
}

@end
