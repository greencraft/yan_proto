//
//  Scenemanager.m
//  yan prototype
//
//  Created by Steve Han on 8/3/11.
//  Copyright 2011 ucsd. All rights reserved.
//

#import "Scenemanager.h"
#import "SynthesizeSingleton.h"
//#import "BGLayer.h"
//#import "MainLayer.h"


@implementation Scenemanager

//static Scenemanager *sharedSceneManager = nil;

//@synthesize spawnPoint = _spawnPoint;
//@synthesize mainLayer = _mainLayer;
//@synthesize bgLayer = _bgLayer;
//@synthesize myString = _myString;
SYNTHESIZE_SINGLETON_FOR_CLASS(Scenemanager);


- (id) init
{
    if ((self = [super init]))
    {
        [_myString retain];
        _myString = @"string property in scene manager";
        
        _bgLayer = [BGLayer node];
        [_bgLayer retain];
        [self addChild:_bgLayer z:0];
        
        _mainLayer = [MainLayer node];
        [_mainLayer retain];
        [self addChild:_mainLayer z:1];
    }
    return self;
}

- (NSString *) getString
{
    return _myString;
}


/*
+ (Scenemanager*) sharedSceneManager
{
    if (sharedSceneManager == nil)
    {
        sharedSceneManager = [[super allocWithZone:NULL] init];
    }
    return sharedSceneManager;
}

- (id) init
{
    if ((self = [super init]))
    {
        self.myString = @"string property in scene manager";
        self.bgLayer = [BGLayer node];
        [self addChild:self.bgLayer z:0];
        
        self.mainLayer = [MainLayer node];
        [self addChild:self.mainLayer z:1];
    }
    return self;
}

+ (id) allocWithZone:(NSZone *)zone
{
    return [[self sharedSceneManager] retain];
    
}

- (id) copyWithZone:(NSZone *) zone
{
    return self;
}

- (id) retain
{
    return self;
}

- (NSUInteger) retainCount
{
    return NSUIntegerMax;  //denotes an object that cannot be released
}

- (void) release
{
    //do nothing
}

- (id) autorelease
{
    return self;
}
*/



@end
