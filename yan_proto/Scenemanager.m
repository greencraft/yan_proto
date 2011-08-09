//
//  Scenemanager.m
//  yan prototype
//
//  Created by Steve Han on 8/3/11.
//  Copyright 2011 ucsd. All rights reserved.
//

#import "Scenemanager.h"


@implementation Scenemanager

@synthesize location = _location;

- (id) init
{
    if ((self = [super init]))
    {
        BGLayer *bgLayer = [BGLayer node];
        [self addChild:bgLayer z:0];
        
        MainLayer *mainLayer = [MainLayer node];
        mainLayer.spawnPoint = bgLayer.spawnPoint;
        [self addChild:mainLayer z:1];
    }
    return self;
}

@end
