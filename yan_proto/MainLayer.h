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
#import "Scenemanager.h"
#import "Constants.h"
#import "Yan.h"


//#define LOGTHIS {};
#define LOGTHIS {(CCLOG(@"\t\t[%@ - %@]", self, NSStringFromSelector(_cmd)));}

@interface MainLayer : CCLayer {
    Yan *_yan;
    CCSpriteBatchNode *sceneSpriteBatchNode;
    
    CGPoint _startPosition;
    CGPoint _endPosition;
    CGFloat _speed;
    CGFloat _unitSpeed;
    CGFloat _angle;
}

@property (nonatomic, retain) Yan *yan;

@property (nonatomic) CGPoint startPosition;
@property (nonatomic) CGPoint endPosition;
@property (nonatomic) CGFloat speed;
@property (nonatomic) CGFloat unitSpeed;
@property (nonatomic) CGFloat angle;


@end
