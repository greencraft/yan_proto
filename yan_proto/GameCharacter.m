//
//  GameCharacter.m
//  yan_proto
//
//  Created by Steve Han on 9/3/11.
//  Copyright 2011 ucsd. All rights reserved.
//

#import "GameCharacter.h"


@implementation GameCharacter
@synthesize characterHealth = _characterHealth; 
@synthesize characterState = _characterState;
@synthesize lastCharacterState = _lastCharacterState;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(int)getWeaponDamage 
{
    // Default to zero damage 
    CCLOG(@"getWeaponDamage should be overridden"); 
    return 0;
}

- (void)dealloc
{
    [super dealloc];
}

@end
