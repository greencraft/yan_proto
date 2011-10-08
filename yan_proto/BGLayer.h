//
//  BGLayer.h
//  yan prototype
//
//  Created by Steve Han on 8/3/11.
//  Copyright 2011 ucsd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Scenemanager.h"

@interface BGLayer : CCLayer {
    CCTMXTiledMap *_tileMap;
    CCTMXLayer *_background;
    CGPoint _spawnPoint;
    CCTMXLayer *_meta;
    CCArray* blah;

}

@property (nonatomic, retain) CCArray* blah;
@property (nonatomic, retain) CCTMXTiledMap *tileMap;
@property (nonatomic, retain) CCTMXLayer *background;
@property (nonatomic) CGPoint spawnPoint;
@property (nonatomic, retain) CCTMXLayer *meta;

-(void)setViewpointCenter:(CGPoint) position;
@end
