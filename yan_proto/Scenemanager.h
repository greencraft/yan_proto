//
//  Scenemanager.h
//  yan_proto
//
//  Created by Steve Han on 8/11/11.
//  Copyright 2011 ucsd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class MainLayer;
@class BGLayer;

@interface Scenemanager : CCScene {
    MainLayer *_mainLayer;
    BGLayer *_bgLayer;
    NSString *_myString;
}

@property (nonatomic, retain) MainLayer *mainLayer;
@property (nonatomic, retain) BGLayer *bgLayer;

+ (Scenemanager*) sharedScenemanager;

@end
