//
//  MainLayer.m
//  yan prototype
//
//  Created by Steve Han on 8/2/11.
//  Copyright 2011 ucsd. All rights reserved.
//

#import "MainLayer.h"

@implementation MainLayer

@synthesize yan = _yan;
@synthesize _randomShip;

@synthesize startPosition = _startPosition;
@synthesize endPosition = _endPosition;
@synthesize speed = _speed;
@synthesize unitSpeed = _unitSpeed;
@synthesize angle = _angle;

#pragma mark –
#pragma mark Update Method
-(void) update:(ccTime)deltaTime 
{
    //CCLOG(@"IN UPDATE METHOD IN MAINLAYER");
    CCArray *listOfGameObjects = 
    [sceneSpriteBatchNode children];                    
    for (GameCharacter *tempChar in listOfGameObjects) 
    {        
        [tempChar updateStateWithDeltaTime:deltaTime andListOfGameObjects:listOfGameObjects];                        
    }
}

- (id) init
{
    if ((self = [super init]))
    {
        //Enable touch events
        self.isTouchEnabled = YES;
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];

 
        //Add player sprite batch node
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"PCAtlas.plist"];
        sceneSpriteBatchNode =[CCSpriteBatchNode batchNodeWithFile:@"PCAtlas.png"];
        
        self.yan = [[Yan alloc] 
                    initWithSpriteFrame:[[CCSpriteFrameCache 
                                          sharedSpriteFrameCache] 
                                         spriteFrameByName:@"PC_runDNeutral.png"]];   
        
        self.yan.position = self.startPosition = ccp(winSize.width/2, winSize.height/2);
        self.yan.startPosition = self.startPosition;
        //[[self.yan texture] setAliasTexParameters];


        //Add sprite to sprite batch node
        [sceneSpriteBatchNode addChild:self.yan z: cYanSpriteZVal tag: cYanSpriteTagVal];
        //Add sprite batch node to the layer
        [self addChild: sceneSpriteBatchNode z: cYanSpriteBatchNodeZVal tag: cYanSpriteBatchNodeTagVal];        

        //Move position of bglayer so the spawn point will be on camera center
        [[[Scenemanager sharedScenemanager] bgLayer] setViewpointCenter:[[Scenemanager sharedScenemanager] bgLayer].spawnPoint];
        
        // create some enemies
        _randomShip = [CCSprite spriteWithFile:@"ship1.png"];
        //[[_enemy1 texture] setAliasTexParameters];
        _randomShip.rotation = 0;
        _randomShip.position = ccp(winSize.width*0.4f, winSize.height*0.65);
        [self addChild:_randomShip z:0];
        
        [self scheduleUpdate];
        
    }
    return self;
}

- (void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //get the touch location
    UITouch *touch = [touches anyObject];
    //get touch point relative to view port, not layer
    self.yan.endPosition = [touch locationInView:[touch view]];
    //convert to current screen orientation
    self.yan.endPosition = [[CCDirector sharedDirector] convertToGL:self.yan.endPosition];
    //convert point from view space to node space
    self.yan.endPosition = [self convertToNodeSpace:self.yan.endPosition];

    self.yan.touchesEnded = NO;
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event 
{
    //get the touch location
    UITouch *touch = [touches anyObject];
    //get touch point relative to view port, not layer
    self.yan.endPosition = [touch locationInView:[touch view]];
    //convert to current screen orientation
    self.yan.endPosition = [[CCDirector sharedDirector] convertToGL:self.yan.endPosition];
    //convert point from view space to node space
    self.yan.endPosition = [self convertToNodeSpace:self.yan.endPosition];
    
    
    //CCLOG(@"THE STARTPOINT IS X: %f, Y: %f", self.startPosition.x, self.startPosition.y);
    //CCLOG(@"THE ENDPOINT IS X: %f, Y: %f", self.endPosition.x, self.endPosition.y);
    
    //[self schedule:@selector(pMove:)];
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event 
{
    //stop action, change this to a specific action instead of all actions
    [[[Scenemanager sharedScenemanager] bgLayer] stopAllActions];
    
    //remove 'move' from the schedule stack to completley stop player
    //[self unschedule:@selector(pMove:)];
    
    self.yan.touchesEnded = YES;
    
}

- (void) dealloc
{
    self.yan = nil;
    [super dealloc];
}
@end
