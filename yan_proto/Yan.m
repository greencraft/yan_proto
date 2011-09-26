//
//  Yan.m
//  yan_proto
//
//  Created by Steve Han on 9/3/11.
//  Copyright 2011 ucsd. All rights reserved.
//

#import "Yan.h"


@implementation Yan

// Yan movement and idle animations
@synthesize YanRunUpAnim;
@synthesize YanRunDownAnim;
@synthesize YanRunLeftAnim;
@synthesize YanRunRightAnim;
@synthesize YanFacingUpIdleAnim;
@synthesize YanFacingDownIdleAnim;
@synthesize YanFacingLeftIdleAnim;
@synthesize YanFacingRightIdleAnim;

// properties for Yan's movement
@synthesize startPosition = _startPosition;
@synthesize endPosition = _endPosition;
@synthesize angle = _angle;
@synthesize speed = _speed;
@synthesize unitSpeed = _unitSpeed;


- (void)dealloc
{
    [YanRunUpAnim release];
    [YanRunDownAnim release];
    [YanRunLeftAnim release];
    [YanRunRightAnim release];
    [YanFacingUpIdleAnim release];
    [YanFacingDownIdleAnim release];
    [YanFacingLeftIdleAnim release];
    [YanFacingRightIdleAnim release];
    
    [super dealloc];
}

- (CharacterStates) checkHeading
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
        return kStateMovingUp;
    }
    else if (self.endPosition.x == self.startPosition.x && self.endPosition.y < self.startPosition.y)
    {
        //CCLOG(@"Going South");
        //go straight south
        return kStateMovingDown;
    }
    else if (self.endPosition.x > self.startPosition.x)
    {
        if (self.endPosition.y >= self.startPosition.y)
        {
            //go northeast or east
            //CCLOG(@"Going NorthEast or East");            
            //if going more up than left, show the moving up sprite, otherwise...
            if (self.angle >= 45.0)
            {
                return kStateMovingUp;
            }
            else
            {
                return kStateMovingRight;
            }
        }
        else if (self.endPosition.y < self.startPosition.y)
        {
            //go southeast
            //CCLOG(@"Going Southeast");
            //if going more down than left, show the moving down sprite, otherwise...
            if (self.angle >= 45.0)
            {
                return kStateMovingDown;
            }
            else
            {
                return kStateMovingRight;
            }
        }
        
    }
    else if (self.endPosition.x < self.startPosition.x)
    {
        if (self.endPosition.y >= self.startPosition.y)
        {
            //CCLOG(@"Going NorthWest or West");
            //go northwest or west
            //if going more up than left, show the moving up sprite, otherwise...
            if (self.angle >= 45.0)
            {
                return kStateMovingUp;
            }
            else
            {
                return kStateMovingLeft;
            }
        }
        else if (self.endPosition.y < self.startPosition.y)
        {
            //CCLOG(@"Going SouthWest");
            //go southeast            
            //if going more down than right, show the moving down sprite, otherwise...
            if (self.angle >= 45.0)
            {
                return kStateMovingDown;
            }
            else
            {
                return kStateMovingLeft;
            }
        }
        
    }
    
    CCLOG(@"Error in moveYan Func, returning idle state");
    return kStateFacingUpIdle;
}


- (CharacterStates)moveYan:(float)deltaTime
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
        [[Scenemanager sharedScenemanager] bgLayer].position = 
        ccp([[Scenemanager sharedScenemanager] bgLayer].position.x, 
            ([[Scenemanager sharedScenemanager] bgLayer].position.y - (self.speed)));
        return kStateMovingUp;
    }
    else if (self.endPosition.x == self.startPosition.x && self.endPosition.y < self.startPosition.y)
    {
        //CCLOG(@"Going South");
        //go straight south
        [[Scenemanager sharedScenemanager] bgLayer].position = 
        ccp([[Scenemanager sharedScenemanager] bgLayer].position.x,
            ([[Scenemanager sharedScenemanager] bgLayer].position.y + (self.speed)));
        return kStateMovingDown;
    }
    else if (self.endPosition.x > self.startPosition.x)
    {
        if (self.endPosition.y >= self.startPosition.y)
        {
            //go northeast or east
            //CCLOG(@"Going NorthEast or East");
            [[Scenemanager sharedScenemanager] bgLayer].position = 
            ccp([[Scenemanager sharedScenemanager] bgLayer].position.x - (self.speed - ((self.angle * self.unitSpeed))), 
                ([[Scenemanager sharedScenemanager] bgLayer].position.y - ((self.angle * self.unitSpeed))));
            
            //if going more up than left, show the moving up sprite, otherwise...
            if (self.angle >= 45.0)
            {
                return kStateMovingUp;
            }
            else
            {
                return kStateMovingRight;
            }
        }
        else if (self.endPosition.y < self.startPosition.y)
        {
            //go southeast
            //CCLOG(@"Going Southeast");
            [[[Scenemanager sharedScenemanager] bgLayer] setPosition: 
            ccp([[Scenemanager sharedScenemanager] bgLayer].position.x - (self.speed - (self.angle * self.unitSpeed)), 
                ([[Scenemanager sharedScenemanager] bgLayer].position.y + (self.angle * self.unitSpeed)))];
            
            //if going more down than left, show the moving down sprite, otherwise...
            if (self.angle >= 45.0)
            {
                return kStateMovingDown;
            }
            else
            {
                return kStateMovingRight;
            }
        }
        
    }
    else if (self.endPosition.x < self.startPosition.x)
    {
        if (self.endPosition.y >= self.startPosition.y)
        {
            //CCLOG(@"Going NorthWest or West");
            //go northwest or west
            [[Scenemanager sharedScenemanager] bgLayer].position = 
            ccp([[Scenemanager sharedScenemanager] bgLayer].position.x + (self.speed - (self.angle * self.unitSpeed)), 
                ([[Scenemanager sharedScenemanager] bgLayer].position.y - (self.angle * self.unitSpeed)));
            
            //if going more up than left, show the moving up sprite, otherwise...
            if (self.angle >= 45.0)
            {
                return kStateMovingUp;
            }
            else
            {
                return kStateMovingLeft;
            }
        }
        else if (self.endPosition.y < self.startPosition.y)
        {
            //CCLOG(@"Going SouthWest");
            //go southeast
            [[Scenemanager sharedScenemanager] bgLayer].position = 
            ccp([[Scenemanager sharedScenemanager] bgLayer].position.x + (self.speed - (self.angle * self.unitSpeed)), 
                ([[Scenemanager sharedScenemanager] bgLayer].position.y + (self.angle * self.unitSpeed)));
            
            //if going more down than right, show the moving down sprite, otherwise...
            if (self.angle >= 45.0)
            {
                return kStateMovingDown;
            }
            else
            {
                return kStateMovingLeft;
            }
        }
        
    }
    
    CCLOG(@"Error in moveYan Func, returning idle state");
    return kStateFacingUpIdle;
}

#pragma mark -
-(void)changeState:(CharacterStates)newState 
{ 
    [self stopAllActions]; 
    id action = nil; 
    [self setCharacterState:newState];
    
    switch (newState) { 
            
        case kStateMovingUp:
            //CCLOG(@"Yan->Changing State to Moving up");
            action = [CCAnimate actionWithAnimation: self.YanRunUpAnim restoreOriginalFrame:YES];
            break;
            
        case kStateMovingDown:
            //CCLOG(@"Yan->Changing State to Moving down");
            action = [CCAnimate actionWithAnimation: self.YanRunDownAnim restoreOriginalFrame:YES];
            break;
            
        case kStateMovingLeft:
            //CCLOG(@"Yan->Changing State to Moving Left");
            action = [CCAnimate actionWithAnimation: self.YanRunLeftAnim restoreOriginalFrame:YES];
            break;
            
        case kStateMovingRight:
            //CCLOG(@"Yan->Changing State to Moving Right");
            action = [CCAnimate actionWithAnimation: self.YanRunRightAnim restoreOriginalFrame:YES];
            break;
            
        case kStateFacingUpIdle:
            //CCLOG(@"Yan->Changing State to Idling Up");
            [self setDisplayFrame:[[CCSpriteFrameCache 
                                    sharedSpriteFrameCache] 
                                   spriteFrameByName:@"PC_runUNeutral.png"]];
            break;
            
        case kStateFacingDownIdle:
            //CCLOG(@"Yan->Changing State to Idling Down");
            [self setDisplayFrame:[[CCSpriteFrameCache 
                                    sharedSpriteFrameCache] 
                                   spriteFrameByName:@"PC_runDNeutral.png"]];       
            break;
            
        case kStateFacingRightIdle:
            //CCLOG(@"Yan->Changing State to Idling Right");
            [self setDisplayFrame:[[CCSpriteFrameCache 
                                    sharedSpriteFrameCache] 
                                   spriteFrameByName:@"PC_runRNeutral.png"]];
            break;
            
        case kStateFacingLeftIdle:
            //CCLOG(@"Yan->Changing State to Idling Left");
            [self setDisplayFrame:[[CCSpriteFrameCache 
                                    sharedSpriteFrameCache] 
                                   spriteFrameByName:@"PC_runLNeutral.png"]];     
            break;
                        
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
    for (GameCharacter *character in listOfGameObjects)
    {
        //if currently looking at yans sprite, skip it
        if([character tag] == cYanSpriteTagVal)
            continue;
        
        CGRect characterBox = [character adjustedBoundingBox];
        if (CGRectIntersectsRect(myBoundingBox, characterBox))
        {
            //colliding with a bullet or enemy, just an example
            if ([character gameObjectType] == kEnemyTypePhaser)
            {
                [self changeState: kStateTakingDamage];
                [character changeState: kStateDead];
            }
            //colliding with a power up, another example
            else if ([character gameObjectType] == kPowerUpTypeHealth)
            {
                [self setCharacterHealth: 100.0f];
                //Remove the power up from the scene
                [character changeState: kStateDead];
            }
        }
        
    }
    
    //****************************************************************************
    
    CharacterStates currentState;
    CharacterStates nextState;
    
    //Change to various states depending on what the player is doing
    if ((self.characterState == kStateFacingUpIdle) ||
        (self.characterState == kStateFacingDownIdle) ||
        (self.characterState == kStateFacingLeftIdle) ||
        (self.characterState == kStateFacingRightIdle) ||
        (self.characterState == kStateMovingUp) ||
        (self.characterState == kStateMovingDown) ||
        (self.characterState == kStateMovingLeft) ||
        (self.characterState == kStateMovingRight))
    {
        if (self.endPosition.x > 0 && self.endPosition.y > 0)
        {
            currentState = self.characterState;
            nextState = [self checkHeading];
            /*if (self.characterState != kStateMovingUp &&
                self.characterState != kStateMovingDown &&
                self.characterState != kStateMovingLeft &&
                self.characterState != kStateMovingRight)
            {*/
            if (currentState != nextState)
            {
                [self changeState: [self checkHeading]];
            }
            [self moveYan:deltaTime];
        }
    }
 
    //****************************************************************************

    //Change Character state to idle if no other actions are being done OR
    //Immediatly stop any moving animations if the player takes their finger off
    if ((([self numberOfRunningActions] == 0) && (self.characterState != kStateDead)) ||
        
        (([self numberOfRunningActions] == 1) && 
         (self.endPosition.x < 0 && self.endPosition.y < 0) &&
         ((self.characterState == kStateMovingUp) ||
          (self.characterState == kStateMovingDown) ||
          (self.characterState == kStateMovingLeft) ||
          (self.characterState == kStateMovingRight)))) 
    { 
        CCLOG(@"Going to Idle"); 
        if (self.characterState == kStateMovingUp)
            [self changeState: kStateFacingUpIdle];
        if (self.characterState == kStateMovingDown)
            [self changeState: kStateFacingDownIdle];
        if (self.characterState == kStateMovingLeft)
            [self changeState: kStateFacingLeftIdle];
        if (self.characterState == kStateMovingRight)
            [self changeState: kStateFacingRightIdle];
        
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
        [self changeState:kStateFacingDownIdle];   
        
        
         //SPEED OF PLAYER MOVEMENT
        self.speed = 3.5;
        self.unitSpeed = (self.speed / 90.0);
    }
        
    return self;
}


@end
