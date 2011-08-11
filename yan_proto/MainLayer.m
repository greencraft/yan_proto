//
//  MainLayer.m
//  yan prototype
//
//  Created by Steve Han on 8/2/11.
//  Copyright 2011 ucsd. All rights reserved.
//

#import "MainLayer.h"
//#import "Scenemanager.h"

@implementation MainLayer

@synthesize player = _player;
@synthesize spawnPoint = _spawnPoint;
@synthesize touchLoc = _touchLoc;



- (id) init
{
    if ((self = [super init]))
    {
        //Enable touch events
        self.isTouchEnabled = YES;
        
        NSString *test = [[Scenemanager sharedSceneManager] getString];
        CCLOG(@"%@", test);
        //Add player sprite
        self.player = [CCSprite spriteWithFile:@"LinkRunShieldD1.png"];
        //self.player.position = [[Scenemanager sharedSceneManager].bgLayer.spawnPoint];
        [self addChild:self.player z:100 tag:1];
        
    }
    return self;
}


- (void)pMove:(ccTime)dt
{
    CCAction *act1 = [CCMoveTo actionWithDuration:1 position:self.touchLoc];
    act1.tag = 1;
    [self.player runAction: act1]; 
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event 
{
    //get the touch location
    UITouch *touch = [touches anyObject];
	self.touchLoc = [touch locationInView:[touch view]];
	self.touchLoc = [[CCDirector sharedDirector] convertToGL:self.touchLoc];
    
    //schedule to move to the location, every .1
    [self schedule:@selector(pMove:) interval:.1];
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event 
{
    //stop action, change this to a specific action instead of all actions
    [self.player stopAllActions];
    
    //remove 'move' from the schedule stack to completley stop player
    [self unschedule:@selector(pMove:)];
}

/*-(void)setViewpointCenter:(CGPoint) position {
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    int x = MAX(position.x, winSize.width / 2);
    int y = MAX(position.y, winSize.height / 2);
    x = MIN(x, (_tileMap.mapSize.width * _tileMap.tileSize.width) 
            - winSize.width / 2);
    y = MIN(y, (_tileMap.mapSize.height * _tileMap.tileSize.height) 
            - winSize.height/2);
    CGPoint actualPosition = ccp(x, y);
    
    CGPoint centerOfView = ccp(winSize.width/2, winSize.height/2);
    CGPoint viewPoint = ccpSub(centerOfView, actualPosition);
    self.position = viewPoint;
    
}*/

- (void) dealloc
{
    self.player = nil;
    [super dealloc];
}
@end
