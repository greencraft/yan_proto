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
@synthesize startPosition = _startPosition;
@synthesize endPosition = _endPosition;
@synthesize speed = _speed;
@synthesize unitSpeed = _unitSpeed;
@synthesize angle = _angle;


- (id) init
{
    if ((self = [super init]))
    {
        //Enable touch events
        self.isTouchEnabled = YES;
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        //SPEED OF PLAYER MOVEMENT
        self.speed = 3.5;
        self.unitSpeed = (self.speed / 90.0);
        
        //Add player sprite batch node
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"PCAtlas.plist"];
        CCSpriteBatchNode *playerSpriteBatchNode =[CCSpriteBatchNode batchNodeWithFile:@"PCAtlas.png"];
        
        //Make player sprite and give it a position
        self.player = [CCSprite spriteWithSpriteFrameName:@"PC_runDNeutral.png"];
        self.player.position = self.startPosition = ccp(winSize.width/2, winSize.height/2);

        //Add sprite to sprite batch node
        [playerSpriteBatchNode addChild:self.player];
        //Add sprite batch node to the layer
        [self addChild: playerSpriteBatchNode z:100];
        

        //Move position of bglayer so the spawn point will be on camera center
        [[[Scenemanager sharedScenemanager] bgLayer] setViewpointCenter:[[Scenemanager sharedScenemanager] bgLayer].spawnPoint];

    }
    return self;
}


- (void)pMove:(ccTime)dt
{
    
    //find the angle
    if ((self.endPosition.x - self.startPosition.x) != 0)
    {
        self.angle = fabs(atanf((self.endPosition.y - self.startPosition.y) / (self.endPosition.x - self.startPosition.x)));
        self.angle = (self.angle * (180.0/ 3.16));
    }

    //Find what direction player is going in and move in that direction at a constant speed
    if (self.endPosition.x == self.startPosition.x && self.endPosition.y > self.startPosition.y)
    {
        CCLOG(@"Going North");
        //go straight north
        [[Scenemanager sharedScenemanager] bgLayer].position = 
                        ccp([[Scenemanager sharedScenemanager] bgLayer].position.x, 
                           ([[Scenemanager sharedScenemanager] bgLayer].position.y - (self.speed)));
    }
    else if (self.endPosition.x == self.startPosition.x && self.endPosition.y < self.startPosition.y)
    {
        CCLOG(@"Going South");
        //go straight south
        [[Scenemanager sharedScenemanager] bgLayer].position = 
                        ccp([[Scenemanager sharedScenemanager] bgLayer].position.x,
                           ([[Scenemanager sharedScenemanager] bgLayer].position.y + (self.speed)));

    }
    else if (self.endPosition.x > self.startPosition.x)
    {
        if (self.endPosition.y >= self.startPosition.y)
        {
            //go northeast or east
            CCLOG(@"Going NorthEast or East");
            [[Scenemanager sharedScenemanager] bgLayer].position = 
                ccp([[Scenemanager sharedScenemanager] bgLayer].position.x - (self.speed - ((self.angle * self.unitSpeed))), 
                   ([[Scenemanager sharedScenemanager] bgLayer].position.y - ((self.angle * self.unitSpeed))));
        }
        else if (self.endPosition.y < self.startPosition.y)
        {
            //go southeast
            CCLOG(@"Going Southeast");
            [[Scenemanager sharedScenemanager] bgLayer].position = 
                ccp([[Scenemanager sharedScenemanager] bgLayer].position.x - (self.speed - (self.angle * self.unitSpeed)), 
                   ([[Scenemanager sharedScenemanager] bgLayer].position.y + (self.angle * self.unitSpeed)));
        }
        
    }
    else if (self.endPosition.x < self.startPosition.x)
    {
        if (self.endPosition.y >= self.startPosition.y)
        {
            CCLOG(@"Going NorthWest or West");
            //go northwest or west
            [[Scenemanager sharedScenemanager] bgLayer].position = 
                ccp([[Scenemanager sharedScenemanager] bgLayer].position.x + (self.speed - (self.angle * self.unitSpeed)), 
                   ([[Scenemanager sharedScenemanager] bgLayer].position.y - (self.angle * self.unitSpeed)));
        }
        else if (self.endPosition.y < self.startPosition.y)
        {
            CCLOG(@"Going SouthWest");
            //go southeast
            [[Scenemanager sharedScenemanager] bgLayer].position = 
                ccp([[Scenemanager sharedScenemanager] bgLayer].position.x + (self.speed - (self.angle * self.unitSpeed)), 
                   ([[Scenemanager sharedScenemanager] bgLayer].position.y + (self.angle * self.unitSpeed)));
        }
        
    }

}
- (void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //get the touch location
    UITouch *touch = [touches anyObject];
    //get touch point relative to view port, not layer
	self.endPosition = [touch locationInView:[touch view]];
    //convert to current screen orientation
	self.endPosition = [[CCDirector sharedDirector] convertToGL:self.endPosition];
    //convert point from view space to node space
    self.endPosition = [self convertToNodeSpace:self.endPosition];
    
    
    //CCLOG(@"THE STARTPOINT IS X: %f, Y: %f", self.startPosition.x, self.startPosition.y);
    //CCLOG(@"THE ENDPOINT IS X: %f, Y: %f", self.endPosition.x, self.endPosition.y);
    
    
    [self schedule:@selector(pMove:)];
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event 
{
    //get the touch location
    UITouch *touch = [touches anyObject];
    //get touch point relative to view port, not layer
	self.endPosition = [touch locationInView:[touch view]];
    //convert to current screen orientation
	self.endPosition = [[CCDirector sharedDirector] convertToGL:self.endPosition];
    //convert point from view space to node space
    self.endPosition = [self convertToNodeSpace:self.endPosition];


    //CCLOG(@"THE STARTPOINT IS X: %f, Y: %f", self.startPosition.x, self.startPosition.y);
    //CCLOG(@"THE ENDPOINT IS X: %f, Y: %f", self.endPosition.x, self.endPosition.y);


    [self schedule:@selector(pMove:)];
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event 
{
    //stop action, change this to a specific action instead of all actions
    [[[Scenemanager sharedScenemanager] bgLayer] stopAllActions];
    
    //remove 'move' from the schedule stack to completley stop player
    [self unschedule:@selector(pMove:)];

}

- (void) dealloc
{
    self.player = nil;
    [super dealloc];
}
@end
