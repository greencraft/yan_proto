//
//  Yan.m
//  yan_proto
//
//  Created by Steve Han on 9/3/11.
//  Copyright 2011 ucsd. All rights reserved.
//

#import "Yan.h"


@implementation Yan

@synthesize touchesEnded = _touchesEnded;

// Yan movement and idle animations
@synthesize YanRunUpAnim = _YanRunUpAnim;
@synthesize YanRunDownAnim = _YanRunDownAnim;
@synthesize YanRunLeftAnim = _YanRunLeftAnim;
@synthesize YanRunRightAnim = _YanRunRightAnim;
@synthesize YanFacingUpIdleAnim = _YanFacingUpIdleAnim;
@synthesize YanFacingDownIdleAnim = _YanFacingDownIdleAnim;
@synthesize YanFacingLeftIdleAnim = _YanFacingLeftIdleAnim;
@synthesize YanFacingRightIdleAnim = _YanFacingRightIdleAnim;

// properties for Yan's movement
@synthesize startPosition = _startPosition;
@synthesize endPosition = _endPosition;
@synthesize angle = _angle;
@synthesize speed = _speed;
@synthesize unitSpeed = _unitSpeed;


- (void)dealloc
{
    [_YanRunUpAnim release];
    [_YanRunDownAnim release];
    [_YanRunLeftAnim release];
    [_YanRunRightAnim release];
    [_YanFacingUpIdleAnim release];
    [_YanFacingDownIdleAnim release];
    [_YanFacingLeftIdleAnim release];
    [_YanFacingRightIdleAnim release];
    
    [super dealloc];
}
/*
#pragma mark -
-(CGRect)adjustedBoundingBox {
    // Adjust the bouding box to the size of the sprite 
    // without the transparent space
    CGRect yanBoundingBox = [self boundingBox];
    float xOffset;
    float xCropAmount = yanBoundingBox.size.width * 0.5482f;
    float yCropAmount = yanBoundingBox.size.height * 0.095f;
    
    if ([self flipX] == NO) {
        // Viking is facing to the rigth, back is on the left
        xOffset = yanBoundingBox.size.width * 0.1566f;
    } else {
        // Viking is facing to the left; back is facing right
        xOffset = yanBoundingBox.size.width * 0.4217f;
    }
    yanBoundingBox = 
    CGRectMake(yanBoundingBox.origin.x + xOffset, 
               yanBoundingBox.origin.y, 
               yanBoundingBox.size.width - xCropAmount, 
               yanBoundingBox.size.height - yCropAmount);
    
    if (self.characterState == kStateCrouching) {
		// Shrink the bounding box to 56% of height
        // 88 pixels on top on iPad
		yanBoundingBox = CGRectMake(yanBoundingBox.origin.x,
									   yanBoundingBox.origin.y, 
									   yanBoundingBox.size.width,
									   yanBoundingBox.size.height * 0.56f);
	}
    
    return yanBoundingBox;
}
*/

- (NSDictionary*)moveYan:(float)deltaTime
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
        //CCLOG(@"Going North");
        //go straight north
        CGPoint tempPoint = 
            ccp([[Scenemanager sharedScenemanager] bgLayer].position.x, 
                ([[Scenemanager sharedScenemanager] bgLayer].position.y - (self.speed)));
        return [NSDictionary dictionaryWithObjectsAndKeys:
                [NSNumber numberWithFloat: tempPoint.x], @"x", 
                [NSNumber numberWithFloat: tempPoint.y], @"y",
                [NSNumber numberWithInt: kNorth], @"heading", 
                nil];
    }
    else if (self.endPosition.x == self.startPosition.x && self.endPosition.y < self.startPosition.y)
    {
        //CCLOG(@"Going South");
        //go straight south
        CGPoint tempPoint =        
            ccp([[Scenemanager sharedScenemanager] bgLayer].position.x,
                ([[Scenemanager sharedScenemanager] bgLayer].position.y + (self.speed)));
        return [NSDictionary dictionaryWithObjectsAndKeys:
                [NSNumber numberWithFloat: tempPoint.x], @"x", 
                [NSNumber numberWithFloat: tempPoint.y], @"y",
                [NSNumber numberWithInt: kSouth], @"heading", 
                nil];
    }
    else if (self.endPosition.x > self.startPosition.x)
    {
        if (self.endPosition.y >= self.startPosition.y)
        {
            //go northeast or east
            //CCLOG(@"Going NorthEast or East");
            CGPoint tempPoint = 
            ccp([[Scenemanager sharedScenemanager] bgLayer].position.x - (self.speed - ((self.angle * self.unitSpeed))), 
                ([[Scenemanager sharedScenemanager] bgLayer].position.y - ((self.angle * self.unitSpeed))));
            
            //if going more up than left, show the moving up sprite, otherwise...
            if (self.angle >= 45.0)
            {
                return [NSDictionary dictionaryWithObjectsAndKeys:
                        [NSNumber numberWithFloat: tempPoint.x], @"x", 
                        [NSNumber numberWithFloat: tempPoint.y], @"y",
                        [NSNumber numberWithInt: kNorth], @"heading", 
                        nil];
            }
            else
            {
                return [NSDictionary dictionaryWithObjectsAndKeys:
                        [NSNumber numberWithFloat: tempPoint.x], @"x", 
                        [NSNumber numberWithFloat: tempPoint.y], @"y",
                        [NSNumber numberWithInt: kEast], @"heading", 
                        nil];
            }
        }
        else if (self.endPosition.y < self.startPosition.y)
        {
            //go southeast or east
            //CCLOG(@"Going Southeast");
            CGPoint tempPoint =
            ccp([[Scenemanager sharedScenemanager] bgLayer].position.x - (self.speed - (self.angle * self.unitSpeed)), 
                ([[Scenemanager sharedScenemanager] bgLayer].position.y + (self.angle * self.unitSpeed)));
            
            //if going more down than left, show the moving down sprite, otherwise...
            if (self.angle >= 45.0)
            {
                return [NSDictionary dictionaryWithObjectsAndKeys:
                        [NSNumber numberWithFloat: tempPoint.x], @"x", 
                        [NSNumber numberWithFloat: tempPoint.y], @"y",
                        [NSNumber numberWithInt: kSouth], @"heading",  //Need to change this heading later
                        nil];
            }
            else
            {
                return [NSDictionary dictionaryWithObjectsAndKeys:
                        [NSNumber numberWithFloat: tempPoint.x], @"x", 
                        [NSNumber numberWithFloat: tempPoint.y], @"y",
                        [NSNumber numberWithInt: kEast], @"heading", 
                        nil];
            }
        }
        
    }
    else if (self.endPosition.x < self.startPosition.x)
    {
        if (self.endPosition.y >= self.startPosition.y)
        {
            //go northwest or west
            CGPoint tempPoint = 
            ccp([[Scenemanager sharedScenemanager] bgLayer].position.x + (self.speed - (self.angle * self.unitSpeed)), 
                ([[Scenemanager sharedScenemanager] bgLayer].position.y - (self.angle * self.unitSpeed)));
            
            //if going more up than left, show the moving up sprite, otherwise...
            if (self.angle >= 45.0)
            {
                return [NSDictionary dictionaryWithObjectsAndKeys:
                        [NSNumber numberWithFloat: tempPoint.x], @"x", 
                        [NSNumber numberWithFloat: tempPoint.y], @"y",
                        [NSNumber numberWithInt: kNorth], @"heading", //need to change later
                        nil];
            }
            else
            {
                return [NSDictionary dictionaryWithObjectsAndKeys:
                        [NSNumber numberWithFloat: tempPoint.x], @"x", 
                        [NSNumber numberWithFloat: tempPoint.y], @"y",
                        [NSNumber numberWithInt: kWest], @"heading", 
                        nil];
            }
        }
        else if (self.endPosition.y < self.startPosition.y)
        {
            //go southwest or west
            CGPoint tempPoint = 
            ccp([[Scenemanager sharedScenemanager] bgLayer].position.x + (self.speed - (self.angle * self.unitSpeed)), 
                ([[Scenemanager sharedScenemanager] bgLayer].position.y + (self.angle * self.unitSpeed)));
            
            //if going more down than right, show the moving down sprite, otherwise...
            if (self.angle >= 45.0)
            {
                return [NSDictionary dictionaryWithObjectsAndKeys:
                        [NSNumber numberWithFloat: tempPoint.x], @"x", 
                        [NSNumber numberWithFloat: tempPoint.y], @"y",
                        [NSNumber numberWithInt: kSouth], @"heading", //change later
                        nil];
            }
            else
            {
                NSDictionary *myDict = [NSDictionary dictionaryWithObjectsAndKeys:
                        [NSNumber numberWithFloat: tempPoint.x], @"x", 
                        [NSNumber numberWithFloat: tempPoint.y], @"y",
                        [NSNumber numberWithInt: kWest], @"heading", 
                        nil];
                return myDict;
            }
        }
        
    }
    
    CCLOG(@"Error in moveYan Func, returning zero state");
    return [NSDictionary dictionaryWithObjectsAndKeys:
            [NSNumber numberWithFloat: 0.0], @"x", 
            [NSNumber numberWithFloat: 0.0], @"y",
            [NSNumber numberWithInt: kNorth], @"heading", 
            nil];
}

#pragma mark -
-(void)changeState:(CharacterStates)newState heading: (CharacterHeading) newHeading
{ 
    [self stopAllActions]; 
    id action = nil; 
    [self setCharacterState:newState];
    self.characterHeading = newHeading;
    
    switch (newState) { 
        // player is changing to a moving state    
        case kStateMoving:
            switch (newHeading) {
                case kNorth:
                    //CCLOG(@"Yan->Changing State to Moving up");
                    action = [CCAnimate actionWithAnimation: self.YanRunUpAnim restoreOriginalFrame:YES];
                    break;
            
                case kSouth:
                    //CCLOG(@"Yan->Changing State to Moving down");
                    action = [CCAnimate actionWithAnimation: self.YanRunDownAnim restoreOriginalFrame:YES];
                    break;
            
                case kWest:
                    //CCLOG(@"Yan->Changing State to Moving Left");
                    action = [CCAnimate actionWithAnimation: self.YanRunLeftAnim restoreOriginalFrame:YES];
                    break;
            
                case kEast:
                    //CCLOG(@"Yan->Changing State to Moving Right");
                    action = [CCAnimate actionWithAnimation: self.YanRunRightAnim restoreOriginalFrame:YES];
                    break;
                }
        // player is changing to an idle state    
        case kStateIdle:
            switch (newHeading) {
                case kNorth:
                    //CCLOG(@"Yan->Changing State to Idling Up");
                    [self setDisplayFrame:[[CCSpriteFrameCache 
                                    sharedSpriteFrameCache] 
                                   spriteFrameByName:@"PC_runUNeutral.png"]];
                    break;
            
                case kSouth:
                    //CCLOG(@"Yan->Changing State to Idling Down");
                    [self setDisplayFrame:[[CCSpriteFrameCache 
                                    sharedSpriteFrameCache] 
                                   spriteFrameByName:@"PC_runDNeutral.png"]];       
                    break;
            
                case kEast:
                    //CCLOG(@"Yan->Changing State to Idling Right");
                    [self setDisplayFrame:[[CCSpriteFrameCache 
                                    sharedSpriteFrameCache] 
                                   spriteFrameByName:@"PC_runRNeutral.png"]];
                    break;
            
                case kWest:
                    //CCLOG(@"Yan->Changing State to Idling Left");
                    [self setDisplayFrame:[[CCSpriteFrameCache 
                                    sharedSpriteFrameCache] 
                                   spriteFrameByName:@"PC_runLNeutral.png"]];     
                    break;
            }                
        default: 
            //CCLOG(@"Unhandled state %d in RadarDish", newState); 
            break;
    } 
    
    if (action != nil) {
        [self runAction:action];
    }
}

#pragma  mark -
-(void)updateStateWithDeltaTime:(ccTime)deltaTime 
           andListOfGameObjects:(CCArray*)listOfGameObjects 
{
    if (self.characterState == kStateDead) 
        return;
    
    if ((self.characterState == kStateTakingDamage) && 
        ([self numberOfRunningActions] > 0))
        return; // Currently playing the taking damage animation
    
    //*************************************************************************
    
    //Check for Collisions
    //Change myBoundingBox to keep the object count from querying it each time
    CGRect myBoundingBox = [self adjustedBoundingBox];
    for (CCSprite *wall in [[Scenemanager sharedScenemanager] bgLayer].blah)
    {
        CCLOG(@"CHECKING FOR COLLISIONS");

        //CGRect wallBox = [wall adjustedBoundingBox];
        if (CGRectIntersectsRect(myBoundingBox, [wall boundingBox]))
            CCLOG(@"COLLIDING WITH A WALL");
    }
    
    for (GameCharacter *character in listOfGameObjects)
    {
        //if currently looking at yans sprite, skip it
        if([character tag] == cYanSpriteTagVal)
            continue;
        
        /*CGRect characterBox = [character adjustedBoundingBox];
        if (CGRectIntersectsRect(myBoundingBox, characterBox))
        {
            //colliding with a bullet or enemy, just an example
            if ([character gameObjectType] == kEnemyTypePhaser)
            {
                //[self changeState: kStateTakingDamage];
                //[character changeState: kStateDead heading: kNeutral];
            }
            //colliding with a power up, another example
            else if ([character gameObjectType] == kPowerUpTypeHealth)
            {
                //[self setCharacterHealth: 100.0f];
                //Remove the power up from the scene
                //[character changeState: kStateDead heading: kNeutral];
            }
        }*/
        
    }
    
    //****************************************************************************
        
    //Change to various states depending on what the player is doing
    if ((self.characterState == kStateMoving) || 
        (self.characterState == kStateIdle))
    {
        //TODO: Need specfic checks to know what action the player is doing
        if (self.touchesEnded == NO)
        {
            NSDictionary* dict = [self moveYan:deltaTime];

            if (self.characterState != kStateMoving || 
                self.characterHeading != [[dict objectForKey:@"heading"] intValue])
            {
                [self changeState: kStateMoving heading: [[dict objectForKey:@"heading"] intValue]];
            }
            self.characterHeading = [[dict objectForKey:@"heading"] intValue];
            [[Scenemanager sharedScenemanager] bgLayer].position = ccp([[dict objectForKey:@"x"] floatValue], 
                                                                       [[dict objectForKey:@"y"] floatValue]);
        }
    }
 
    //****************************************************************************

    //Change Character state to idle if no other actions are being done OR
    //Immediatly stop any moving animations if the player takes their finger off
    
    if ((([self numberOfRunningActions] == 0) && (self.characterState != kStateDead)) ||
        
        (([self numberOfRunningActions] == 1) && (self.touchesEnded == YES) && (self.characterState == kStateMoving)))
    { 
        [self changeState: kStateIdle heading: self.characterHeading];

        return;
    }
}

-(void)initAnimations
{
    //initiate Yan Run Animations
    [self setYanRunUpAnim: 
     [self loadPlistForAnimationWithName:@"YanRunUpAnim" 
                            andClassName:NSStringFromClass([self class])]];
    [self setYanRunDownAnim: 
     [self loadPlistForAnimationWithName:@"YanRunDownAnim" 
                            andClassName:NSStringFromClass([self class])]];
    [self setYanRunLeftAnim: 
     [self loadPlistForAnimationWithName:@"YanRunLeftAnim" 
                            andClassName:NSStringFromClass([self class])]];
    [self setYanRunRightAnim: 
     [self loadPlistForAnimationWithName:@"YanRunRightAnim" 
                            andClassName:NSStringFromClass([self class])]];
    
    //initiate Yan idle animations
    [self setYanFacingUpIdleAnim: 
     [self loadPlistForAnimationWithName:@"YanFacingUpIdleAnim" 
                            andClassName:NSStringFromClass([self class])]];
    
    [self setYanFacingDownIdleAnim: 
     [self loadPlistForAnimationWithName:@"YanFacingDownIdleAnim" 
                            andClassName:NSStringFromClass([self class])]];
    
    [self setYanFacingLeftIdleAnim: 
     [self loadPlistForAnimationWithName:@"YanFacingLeftIdleAnim" 
                            andClassName:NSStringFromClass([self class])]];
    
    [self setYanFacingRightIdleAnim: 
     [self loadPlistForAnimationWithName:@"YanFacingRightIdleAnim" 
                            andClassName:NSStringFromClass([self class])]];
    

}

            
- (id)init
{
    self = [super init];
    if (self) 
    {
        CCLOG(@"### Yan initialized"); 
        [self initAnimations]; 
        self.gameObjectType = kYanType; 
        self.touchesEnded = YES;
        [self changeState:kStateIdle heading: kSouth];   
        
        
         //SPEED OF PLAYER MOVEMENT
        self.speed = 3.5;
        self.unitSpeed = (self.speed / 90.0);
    }
        
    return self;
}


@end
