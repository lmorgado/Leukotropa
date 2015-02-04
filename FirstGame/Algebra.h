//
//  Algebra.h
//  FirstGame
//
//  Created by Jordan Rodrigues Rangel on 1/28/15.
//  Copyright (c) 2015 Jordan Rodrigues Rangel. All rights reserved.
//

#ifndef FirstGame_Algebra_h
#define FirstGame_Algebra_h

static const float ALGEBRA_PI = 3.14159265358979f;
static const float ALGEBRA_PI_BY2 = 1.5707963267949;

static inline float degToRad(float degree) {
    
    return degree / 180.0f * M_PI;
}

static inline CGPoint rwAdd(CGPoint a, CGPoint b) {
    return CGPointMake(a.x + b.x, a.y + b.y);
}

static inline CGPoint rwSub(CGPoint a, CGPoint b) {
    return CGPointMake(a.x - b.x, a.y - b.y);
}

static inline CGPoint rwMult(CGPoint a, float b) {
    return CGPointMake(a.x * b, a.y * b);
}

static inline float rwLength(CGPoint a) {
    return sqrtf(a.x * a.x + a.y * a.y);
}

// Makes a vector have a length of 1
static inline CGPoint rwNormalize(CGPoint a) {
    float length = rwLength(a);
    return CGPointMake(a.x / length, a.y / length);
}

static inline float rwRotation(CGPoint a)
{
    float arctg = tanhf(a.y/a.x);
    
    if(a.x < 0.0f)
    {
        if(a.y >=0.0f)
            arctg += ALGEBRA_PI;
        else
            arctg -= ALGEBRA_PI;
    }
    
    return arctg;
}


#endif
