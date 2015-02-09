//
//  TowerClass.m
//  FirstGame
//
//  Created by Jordan Rodrigues Rangel on 1/28/15.
//  Copyright (c) 2015 Jordan Rodrigues Rangel. All rights reserved.
//

#import "TowerClass.h"

@interface TowerClass()

@property (nonatomic) float range;
@property (nonatomic) float delay;
@property (nonatomic) BOOL isActive;
@property (nonatomic) NSString * imgName;
@property (nonatomic) TypeOfTower type;
@property (nonatomic) int cost;

@end

@implementation TowerClass

//Método Construtor
-(instancetype)initWithType: (TypeOfTower) type
{
    
    //Descobre qual imagem usar.
    switch(type)
    {
        case INDIANTOWER:
        {
            self.imgName = @"indianTower.png";
            break;
        }
        case SPACETOWER:
        {
            self.imgName = @"spaceTower.png";
            break;
        }
        case BOMBTOWER:
        {
            self.imgName = @"bombTower.png";
            break;
        }
        case FIRETOWER:
        {
            self.imgName = @"fireTower.png";
            break;
        }
        case HERO:
        {
            self.imgName = @"hero.png";
            break;
        }
        default:
            break;
    }
    //FIM
    
    //Seta todas as características
    if(self = [super initWithImageNamed:self.imgName])
    {
        self.type = type;
        
        switch(type)
        {
            case INDIANTOWER:
            {
                self.range = 100.0f;
                self.delay = 0.5f;
                self.lastSpawnTimeInterval = 5.0f;
                self.cost = 30;
                break;
            }
            case SPACETOWER:
            {
                self.range = 100.0f;
                self.delay = 0.5f;
                self.lastSpawnTimeInterval = 5.0f;
                self.cost = 50;
                break;
            }
            case BOMBTOWER:
            {
                self.range = 100.0f;
                self.delay = 0.5f;
                self.lastSpawnTimeInterval = 5.0f;
                self.cost = 75;
                break;
            }
            case FIRETOWER:
            {
                self.range = 100.0f;
                self.delay = 0.5f;
                self.lastSpawnTimeInterval = 5.0f;
                self.cost = 100;
                break;
            }
            default:
                break;
        }
    }
    //FIM
    
    //Seta como não ativa.
    self.isActive = NO;
    
    return self;
}

//Retorna o nome da imagem.
-(NSString *)imageName
{
    return self.imgName;
}

//Retorna o alcance da torre.
-(float)getRange
{
    return self.range;
}

//Retorna o delay de tiro da torre.
-(float)getDelay
{
    return self.delay;
}

-(TypeOfTower)getType
{
    return self.type;
}

-(int)getCost
{
    return self.cost;
}

@end