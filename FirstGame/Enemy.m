//
//  Enemy.m
//  FirstGame
//
//  Created by Jordan Rodrigues Rangel on 1/28/15.
//  Copyright (c) 2015 Jordan Rodrigues Rangel. All rights reserved.
//

#import "Enemy.h"
#include "Algebra.h"

@interface Enemy()

//Movimento do inimigo
@property (nonatomic) CGPoint destiny;

//Velocidade do inimigo
@property (nonatomic) float speed;

//Vida do inimigo
@property (nonatomic) int life;

//Imagem
@property (nonatomic) NSString * imgName;

//Dano causado pelo inimigo
@property (nonatomic) int damage;

//Inimigo ativo
@property (nonatomic) BOOL isActive;

@end

@implementation Enemy

- (instancetype) initWithSpeed:(float) speed withPosition:(CGPoint) position withLife: (int)life image:(NSString*)imgName andDamage:(int)damage{
    
    if(self = [super initWithImageNamed:imgName])
    {
        CGSize size = self.size;
        
        self.life = life;
        self.imgName = imgName;
        self.damage = damage;
        self.size = CGSizeMake(size.width/20.0f, size.height/20.0f);
        self.position = CGPointMake(-self.size.width/2.0f, position.y);
        self.speed = speed;
        self.isActive = YES;
    }
    
    return self;
}

-(void) moveTo:(CGMutablePathRef) actionPath pathLength:(float)distance gameScene:(GameScene*) scene
{
    
    SKAction *followline = [SKAction followPath:actionPath asOffset:NO orientToPath:NO duration:distance/self.speed];
    
    SKAction * removeLife = [SKAction runBlock:^{
        [scene removeLife];
        self.isActive = NO;
    }];
    
    SKAction * finalAction = [SKAction sequence:@[followline, removeLife, [SKAction removeFromParent]]];
    //[self runAction:[SKAction moveTo:destiny duration:(rwLength (rwSub(destiny, self.position))/self.speed)]];
    [self runAction:finalAction];
}

-(float) getSpeed{
    return self.speed;
}

-(BOOL) causeDamage:(int) damage
{
    self.life -= damage;
    
    if(self.life <= 0)
    {
        self.isActive = NO;
        return YES;
    }
    return NO;
}

-(BOOL) getIsActive
{
    return self.isActive;
}

@end