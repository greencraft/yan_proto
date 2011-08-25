//
//  MainLayer.h
//  yan prototype
//
//  Created by Steve Han on 8/2/11.
//  Copyright 2011 ucsd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "BGLayer.h"
//@class Scenemanager;
#import "Scenemanager.h"


//#define LOGTHIS {};
#define LOGTHIS {(CCLOG(@"\t\t[%@ - %@]", self, NSStringFromSelector(_cmd)));}

@interface MainLayer : CCLayer {
    CCSprite *_player;
    CGPoint _startPosition;
    CGPoint _endPosition;
    CGFloat _speed;
    CGFloat _angle;
    CGFloat _unitSpeed;
}

@property (nonatomic, retain) CCSprite *player;
@property (nonatomic) CGPoint startPosition;
@property (nonatomic) CGPoint endPosition;
@property (nonatomic) CGFloat speed;
@property (nonatomic) CGFloat angle;
@property (nonatomic) CGFloat unitSpeed;


@end
