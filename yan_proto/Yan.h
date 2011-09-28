//
//  Yan.h
//  yan_proto
//
//  Created by Steve Han on 9/3/11.
//  Copyright 2011 ucsd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameCharacter.h"
#import "Scenemanager.h"
#import "BGLayer.h"


typedef enum 
{
    kLeftHook,
    kRightHook 
} LastPunchType;

@interface Yan : GameCharacter {
    
    // Flag to know when there is no touch input
    BOOL _touchesEnded;
    
    // Running 
    CCAnimation *_YanRunUpAnim;
    CCAnimation *_YanRunDownAnim;
    CCAnimation *_YanRunLeftAnim;
    CCAnimation *_YanRunRightAnim;
    CCAnimation *_YanFacingUpIdleAnim;
    CCAnimation *_YanFacingDownIdleAnim;
    CCAnimation *_YanFacingLeftIdleAnim;
    CCAnimation *_YanFacingRightIdleAnim;
    
    CGPoint _startPosition;
    CGPoint _endPosition;
    CGFloat _angle;
    CGFloat _speed;
    CGFloat _unitSpeed;
    
}

@property (nonatomic) BOOL touchesEnded;

// Running
@property (nonatomic, retain) CCAnimation *YanRunUpAnim;
@property (nonatomic, retain) CCAnimation *YanRunDownAnim;
@property (nonatomic, retain) CCAnimation *YanRunLeftAnim;
@property (nonatomic, retain) CCAnimation *YanRunRightAnim;
@property (nonatomic, retain) CCAnimation *YanFacingUpIdleAnim;
@property (nonatomic, retain) CCAnimation *YanFacingDownIdleAnim;
@property (nonatomic, retain) CCAnimation *YanFacingLeftIdleAnim;
@property (nonatomic, retain) CCAnimation *YanFacingRightIdleAnim;

@property (nonatomic, assign) CGPoint startPosition;
@property (nonatomic, assign) CGPoint endPosition;
@property (nonatomic, assign) CGFloat angle;
@property (nonatomic, assign) CGFloat speed;
@property (nonatomic, assign) CGFloat unitSpeed;



@end
