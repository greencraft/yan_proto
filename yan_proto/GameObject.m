//
//  GameObject.m
//  yan_proto
//
//  Created by Steve Han on 8/31/11.
//  Copyright 2011 ucsd. All rights reserved.
//

#import "GameObject.h"


@implementation GameObject

@synthesize reactsToScreenBoundaries; 
@synthesize screenSize;
@synthesize isActive;
@synthesize gameObjectType;

- (id)init
{
    self = [super init];
    if (self) {
        CCLOG(@"GameObject Init");
        screenSize = [CCDirector sharedDirector].winSize;
        isActive = TRUE;
        gameObjectType = kObjectTypeNone;
    }
    
    return self;
}

-(void)changeState:(CharacterStates)newState 
{
    CCLOG(@"GameObject->changeState method should be overridden");
} 

-(void)changeState:(CharacterStates)newState heading: (CharacterHeading)newHeading
{
    CCLOG(@"GameObject->changeState method should be overridden");
} 

-(void)updateStateWithDeltaTime:(ccTime)deltaTime
           andListOfGameObjects:(CCArray*)listOfGameObjects 
{ 
    CCLOG(@"updateStateWithDeltaTime method should be overridden");
}

-(CGRect)adjustedBoundingBox 
{ 
    //CCLOG(@"GameObect adjustedBoundingBox should be overridden"); 
    return [self boundingBox];
}

-(CCAnimation*)loadPlistForAnimationWithName:(NSString*)animationName 
                                andClassName:(NSString*)className 
{
    CCAnimation *animationToReturn = nil; 
    NSString *fullFileName = [NSString stringWithFormat:@"%@.plist",className]; 
    NSString *plistPath;
    
    // 1: Get the Path to the plist file
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                              NSUserDomainMask, YES) objectAtIndex:0]; 
    plistPath = [rootPath stringByAppendingPathComponent:fullFileName]; 
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) 
    {
        plistPath = [[NSBundle mainBundle] pathForResource:className ofType:@"plist"];
    }
    
    // 2: Read in the plist file
    NSDictionary *plistDictionary = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    // 3: If the plistDictionary was null, the file was not found.
    if (plistDictionary == nil) 
    {
        CCLOG(@"Error reading plist: %@.plist", className); 
        return nil; // No Plist Dictionary or file found
    }
    
    // 4: Get just the mini-dictionary for this animation
    NSDictionary *animationSettings = [plistDictionary objectForKey:animationName]; 
    if (animationSettings == nil) 
    {
        CCLOG(@"Could not locate AnimationWithName:%@",animationName); 
        return nil;
    }
    
    // 5: Get the delay value for the animation
    float animationDelay = [[animationSettings objectForKey:@"delay"] floatValue]; 
    animationToReturn = [CCAnimation animation]; 
    [animationToReturn setDelay:animationDelay];
    
    // 6: Add the frames to the animation
    NSString *animationFramePrefix = [animationSettings objectForKey:@"filenamePrefix"];
    NSString *animationFrames = [animationSettings objectForKey:@"animationFrames"]; 
    NSArray *animationFrameNumbers = [animationFrames componentsSeparatedByString:@","];
    
    for (NSString *frameNumber in animationFrameNumbers) 
    {
        NSString *frameName = [NSString stringWithFormat:@"%@%@.png", animationFramePrefix,frameNumber]; 
        [animationToReturn addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:frameName]];  
    }
    
    return animationToReturn;
}

//Used for collision detection purposes, this functions will calculate where the corner points of the bounding box of this sprite
//is going to be.
- (void) findNextPosition: (NSDictionary*) dict
{
    CCLOG(@"HELLO IN FINDNEXTPOSITION");
    //This is the where Yan's corner points will be on this frame if he is moving
    
    cornerVertices = [NSMutableArray arrayWithObjects:
                      [NSValue valueWithCGPoint:ccp(CGRectGetMinX(self.boundingBox) - [[dict objectForKey:@"x"] floatValue],
                                                    CGRectGetMaxY(self.boundingBox) - [[dict objectForKey:@"y"] floatValue])],
                      [NSValue valueWithCGPoint:ccp(CGRectGetMaxX(self.boundingBox) - [[dict objectForKey:@"x"] floatValue],
                                                    CGRectGetMaxY(self.boundingBox) - [[dict objectForKey:@"y"] floatValue])],
                      [NSValue valueWithCGPoint:ccp(CGRectGetMinX(self.boundingBox) - [[dict objectForKey:@"x"] floatValue],
                                                    CGRectGetMinY(self.boundingBox) - [[dict objectForKey:@"y"] floatValue])],
                      [NSValue valueWithCGPoint:ccp(CGRectGetMaxX(self.boundingBox) - [[dict objectForKey:@"x"] floatValue],
                                                    CGRectGetMinY(self.boundingBox) - [[dict objectForKey:@"y"] floatValue])],
                      nil];
    
    cornerVerticesX = [NSMutableArray arrayWithObjects:
                       [NSValue valueWithCGPoint:ccp(CGRectGetMinX(self.boundingBox) - [[dict objectForKey:@"x"] floatValue],
                                                     CGRectGetMaxY(self.boundingBox))],
                       [NSValue valueWithCGPoint:ccp(CGRectGetMaxX(self.boundingBox) - [[dict objectForKey:@"x"] floatValue],
                                                     CGRectGetMaxY(self.boundingBox))],
                       [NSValue valueWithCGPoint:ccp(CGRectGetMinX(self.boundingBox) - [[dict objectForKey:@"x"] floatValue],
                                                     CGRectGetMinY(self.boundingBox))],
                       [NSValue valueWithCGPoint:ccp(CGRectGetMaxX(self.boundingBox) - [[dict objectForKey:@"x"] floatValue],
                                                     CGRectGetMinY(self.boundingBox))],
                       nil];
    
    cornerVerticesY = [NSMutableArray arrayWithObjects:
                       [NSValue valueWithCGPoint:ccp(CGRectGetMinX(self.boundingBox),
                                                     CGRectGetMaxY(self.boundingBox) - [[dict objectForKey:@"y"] floatValue])],
                       [NSValue valueWithCGPoint:ccp(CGRectGetMaxX(self.boundingBox),
                                                     CGRectGetMaxY(self.boundingBox) - [[dict objectForKey:@"y"] floatValue])],
                       [NSValue valueWithCGPoint:ccp(CGRectGetMinX(self.boundingBox),
                                                     CGRectGetMinY(self.boundingBox) - [[dict objectForKey:@"y"] floatValue])],
                       [NSValue valueWithCGPoint:ccp(CGRectGetMaxX(self.boundingBox),
                                                     CGRectGetMinY(self.boundingBox) - [[dict objectForKey:@"y"] floatValue])],
                       nil];
    
    // Convert those corner points to points in bgLayer space
    for (int i = 0; i <= 3; i++)
    {
        CCLOG(@"I HOPE I'M NOT AN INFINITE LOOP");
        //pull them from the array
        CGPoint temp = [[cornerVertices objectAtIndex:i] CGPointValue];
        CGPoint tempX = [[cornerVerticesX objectAtIndex:i] CGPointValue];
        CGPoint tempY = [[cornerVerticesY objectAtIndex:i] CGPointValue];
        
        //Convert these coordinates to bgLayer coords
        temp = [[[Scenemanager sharedScenemanager] bgLayer].meta convertToNodeSpace:temp];
        tempX = [[[Scenemanager sharedScenemanager] bgLayer].meta convertToNodeSpace:tempX];
        tempY = [[[Scenemanager sharedScenemanager] bgLayer].meta convertToNodeSpace:tempY];
        
        //then find the Tiled map tile those coordinates lie on
        temp = [[[Scenemanager sharedScenemanager] bgLayer] tileCoordForPosition: temp];
        tempX = [[[Scenemanager sharedScenemanager] bgLayer] tileCoordForPosition: tempX];
        tempY = [[[Scenemanager sharedScenemanager] bgLayer] tileCoordForPosition: tempY];
        
        //reinsert them (thats what she said)
        [cornerVertices replaceObjectAtIndex:i withObject: [NSValue valueWithCGPoint:temp]];
        [cornerVerticesX replaceObjectAtIndex:i withObject: [NSValue valueWithCGPoint:tempX]];
        [cornerVerticesY replaceObjectAtIndex:i withObject: [NSValue valueWithCGPoint:tempY]];
    }
    
}

- (void)dealloc
{
    [super dealloc];
}

@end
