//
//  MainLayer.m
//  yan prototype
//
//  Created by Steve Han on 8/2/11.
//  Copyright 2011 ucsd. All rights reserved.
//

#import "MainLayer.h"
#import "BGLayer.h"


@implementation MainLayer

@synthesize player = _player;
@synthesize location = _location;

- (id) init
{
    if ((self = [super init]))
    {
        //Enable touch events
        self.isTouchEnabled = YES;
        
        
        //Add player sprite
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        self.player = [CCSprite spriteWithFile:@"LinkRunShieldD1.png"];
        self.player.position = ccp(winSize.width/2, winSize.height/2);
        [self addChild:self.player z:100 tag:1];
        
    }
    return self;
}


- (void)pMove:(ccTime)dt
{
    CCAction *act1 = [CCMoveTo actionWithDuration:1 position:self.location];
    act1.tag = 1;
    [self.player runAction: act1]; 
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event 
{
    //get the touch location
    UITouch *touch = [touches anyObject];
	self.location = [touch locationInView:[touch view]];
	self.location = [[CCDirector sharedDirector] convertToGL:self.location];
    
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

- (void) dealloc
{
    self.player = nil;
    [super dealloc];
}
@end
