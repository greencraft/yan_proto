//
//  Scenemanager.m
//  yan_proto
//
//  Created by Steve Han on 8/11/11.
//  Copyright 2011 ucsd. All rights reserved.
//

#import "Scenemanager.h"
#import "SynthesizeSingleton.h"
#import "BGLayer.h"
#import "MainLayer.h"

@implementation Scenemanager

SYNTHESIZE_SINGLETON_FOR_CLASS(Scenemanager);


@synthesize mainLayer = _mainLayer;
@synthesize bgLayer = _bgLayer;

//some thread said that using properties in the init for a singleton class is not a good a idea...look into it later
- (id) init
{
    if ((self = [super init]))
    {
        //_myString = @"string property in scene manager";
        
        [self setBgLayer:[BGLayer node]];
        //[_bgLayer retain];
        [self addChild:[self bgLayer] z:0];
        
        [self setMainLayer:[MainLayer node]];
        //[_mainLayer retain];
        [self addChild:[self mainLayer] z:1];
    }
    return self;
}


@end
