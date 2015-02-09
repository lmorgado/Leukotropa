//
//  Red.m
//  FirstGame
//
//  Created by Stefano Politi on 08/02/15.
//  Copyright (c) 2015 Jordan Rodrigues Rangel. All rights reserved.
//

#import "Red.h"
@interface Red()

//Nome da imagem do Red.
@property (nonatomic) NSString *imgName;

//Velocidade do Red
@property (nonatomic) float speed;





@end


@implementation Red

//Metodo Construtor
-(instancetype) initWithPosition: (CGPoint) position
{
    if(self = [super initWithImageNamed:@"red.png"])
    {
        CGSize size = self.size;
        self.size = CGSizeMake(size.width/40.0f, size.height/40.0f);
        self.position = CGPointMake(position.x, position.y);
        
        self.speed = 13.0f;
        self.imgName = @"red.png";
    }
    return self;
}

// Metodo que o red percorre o caminho todoe morre ao final.
- (void) moveTo: (CGMutablePathRef)actionPath pathLength: (float)distance gameScene: (GameScene*)scene
{
    
    SKAction *followline = [SKAction followPath:actionPath asOffset:NO orientToPath:NO duration:distance/self.speed];
    
    SKAction *extraPoints = [SKAction runBlock:^{
        [scene extraPoints:10];
    }];
    
    SKAction *finalAction = [SKAction sequence: @[followline, extraPoints, [SKAction removeFromParent]]];
    
    [self runAction : finalAction];
}

-(void) killRed
{
    [self runAction:[SKAction removeFromParent]];
}

@end



