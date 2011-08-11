//
//  Scenemanager.h
//  yan prototype
//
//  Created by Steve Han on 8/3/11.
//  Copyright 2011 ucsd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class MainLayer;
@class BGLayer;
#import "BGLayer.h"
#import "MainLayer.h"



@interface Scenemanager : CCScene 
{
    CGPoint _spawnPoint;
    MainLayer *_mainLayer;
    BGLayer *_bgLayer;
    NSString *_myString;

}

//@property (nonatomic) CGPoint spawnPoint;
//@property (nonatomic, retain) MainLayer *mainLayer;
//@property (nonatomic, retain) BGLayer *bgLayer;
//@property (nonatomic, retain) NSString *myString;

+ (Scenemanager*) sharedSceneManager;
- (NSString *) getString;

@end
