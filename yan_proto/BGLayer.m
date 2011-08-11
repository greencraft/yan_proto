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
@synthesize spawnPoint = _spawnPoint;

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
        
        //get the tilemap
        [self setTileMap: [CCTMXTiledMap tiledMapWithTMXFile:@"Background.tmx"]];
        //get the background layer from the tilemap
        [self setBackground: [_tileMap layerNamed:@"Background"]];
        //add tilemap to scene
        [self addChild:_tileMap z:-1];
        
        //************************************************
        
        //get the object layer from the tilemap
        CCTMXObjectGroup *objects = [_tileMap objectGroupNamed:@"Objects"];
        NSAssert(objects != nil, @"'Objects' object group not found");
        
        //get the spawn point object from object layer
        NSMutableDictionary *tempSpawnPoint = [objects objectNamed:@"SpawnPoint"];        
        NSAssert(tempSpawnPoint != nil, @"SpawnPoint object not found");
        
        //set the variables for the spawnpoint location
        int x = [[tempSpawnPoint valueForKey:@"x"] intValue];
        int y = [[tempSpawnPoint valueForKey:@"y"] intValue];
        //set spawnpoint loc, this is passed to scenemanager where mainlayer takes it
        [self setSpawnPoint: ccp(x, y)];
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
