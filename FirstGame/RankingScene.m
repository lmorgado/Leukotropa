//
//  RankingScene.m
//  FirstGame
//
//  Created by Stefano Politi on 28/01/15.
//  Copyright (c) 2015 Jordan Rodrigues Rangel. All rights reserved.
//

#import "RankingScene.h"
#import "GameScene.h"

@interface RankingScene()

@property (nonatomic) UILabel * rankingLabel;
@property (nonatomic) NSMutableArray * highscoreArray;
@property (nonatomic) UIButton * startButton;

@end

@implementation RankingScene




-(id)initWithSize:(CGSize)size {
    
    if (self = [super initWithSize:size]) {
        // Imagem Background
        SKSpriteNode * background = [[SKSpriteNode alloc] initWithImageNamed:@"opçao_01.jpg"];
        background.position = CGPointMake(size.width/2.0f, size.height/2.0f);
        background.size = size;
        [self addChild:background];
        // FIM Background
        
        // Label
        self.rankingLabel = [[UILabel alloc] init];
        [self.rankingLabel setFrame: CGRectMake(0.0, 0.0, size.width/2, size.height/2)];
        //self.rankingLabel.backgroundColor=[UIColor whiteColor];
        self.rankingLabel.textColor=[UIColor cyanColor];
        self.rankingLabel.userInteractionEnabled = NO;
        self.rankingLabel.textAlignment = NSTextAlignmentCenter;
        self.rankingLabel.adjustsFontSizeToFitWidth = YES;
        self.rankingLabel.numberOfLines = 0;
       // FIM Label
    
        // Plist
        NSString * plistPath;
        
        NSString * rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        plistPath = [rootPath stringByAppendingPathComponent:@"Ranking.plist"];
        
        if(![[NSFileManager defaultManager] fileExistsAtPath:plistPath])
        {
            plistPath = [[NSBundle mainBundle] pathForResource:@"Ranking" ofType:@"plist"];
        }
        // FIM Plist
        
        // Ordera as Strings pela chave "Score"
        self.highscoreArray = [NSMutableArray arrayWithContentsOfFile:plistPath];
        
        [self sort];
        // FIM Ordenacao
    
        int maximo = self.highscoreArray.count;
    
        if (maximo > 10)
            maximo = 10;
        
        NSMutableString * mutString = [[NSMutableString alloc] initWithString:@"RANKING\n"];
    
        for (int i=0; i<maximo;i++)
        {
            NSLog(@"%@ - %@",self.highscoreArray[i][@"Name"],self.highscoreArray[i][@"Score"]);
        
            [mutString appendString: [NSString stringWithFormat:@"%@ - %@\n",self.highscoreArray[i][@"Name"],self.highscoreArray[i][@"Score"]]];
        }
        //FIM
        
        
        
        self.rankingLabel.text = mutString;
        
        
    }
    
    //Label Position
    // self.rankingLabel.position = CGPointMake(size.width/2 - self.size.width/2, size.height/2);
    
    //Botao Jogar
    self.startButton = [[UIButton alloc] initWithFrame:CGRectMake(size.width - 230.0f, size.height - 100.0f, 200.0f, 60.0f)];
    self.startButton.backgroundColor = [[UIColor alloc] initWithRed:0.9f green:0.2f blue:0.6f alpha:0.6];
    [self.startButton setTitle:@"Jogar Novamente" forState:UIControlStateNormal];
    [self.startButton addTarget:self action:@selector(goNextScreen) forControlEvents:UIControlEventTouchUpInside];
    
    return self;
}

-(void)didMoveToView:(SKView *)view
{
    
    [self.view addSubview:self.rankingLabel];
    
    [self.view addSubview:self.startButton];
    
    
}

-(void)sort
{
    //    self.plist = [self.plist sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
    //        return [[obj1 valueForKey:@"Score"] compare:[obj2 valueForKey:@"Score"]];
    //    }];
    
    NSSortDescriptor * sd = [NSSortDescriptor sortDescriptorWithKey:@"Score" ascending:NO];
    NSArray * sortDesc = [NSArray arrayWithObject:sd];
    self.highscoreArray = [NSMutableArray arrayWithArray:[self.highscoreArray sortedArrayUsingDescriptors:sortDesc] ];
}

-(void)goNextScreen
{
    self.startButton.hidden = YES;
    self.rankingLabel.hidden = YES;
    
    SKAction *nextGameAction = [SKAction runBlock:^{
        SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
        SKScene * myScene = [[GameScene alloc] initWithSize:self.size];
        [self.view presentScene:myScene transition: reveal];
    }];
    
    [self runAction:nextGameAction];
}

@end