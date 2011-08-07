//
//  BGLayer.m
//  yan prototype
//
//  Created by Steve Han on 8/3/11.
//  Copyright 2011 ucsd. All rights reserved.
//

#import "BGLayer.h"


@implementation BGLayer

@synthesize tileMap = _tileMap;
@synthesize background = _background;

- (id) init
{
    if ((self = [super init]))
    {
        /*
        CCSprite *BGImage = [CCSprite spriteWithFile:@"Mastersword_forest.png"];
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        BGImage.position = ccp(winSize.width/2, winSize.height/2);
        [self addChild:BGImage z:0 tag:0];
         */
        
        self.tileMap = [CCTMXTiledMap tiledMapWithTMXFile:@"Background.tmx"];
        self.background = [_tileMap layerNamed:@"Background"];
        
        [self addChild:_tileMap z:-1];
    }
    return self;
        
}

- (void) dealloc
{
    self.tileMap = nil;
    self.background = nil;
    [super dealloc];
}

@end
