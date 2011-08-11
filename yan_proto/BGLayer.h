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
}

@property (nonatomic, retain) CCTMXTiledMap *tileMap;
@property (nonatomic, retain) CCTMXLayer *background;
@property (nonatomic) CGPoint spawnPoint;

@end
