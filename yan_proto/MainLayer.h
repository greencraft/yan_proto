//
//  MainLayer.h
//  yan prototype
//
//  Created by Steve Han on 8/2/11.
//  Copyright 2011 ucsd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"


//#define LOGTHIS {};
#define LOGTHIS {(CCLOG(@"\t\t[%@ - %@]", self, NSStringFromSelector(_cmd)));}

@interface MainLayer : CCLayer {
    CCSprite *player;
    CGPoint location;
    
}

@end
