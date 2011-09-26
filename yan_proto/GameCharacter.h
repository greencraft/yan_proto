//
//  GameCharacter.h
//  yan_proto
//
//  Created by Steve Han on 9/3/11.
//  Copyright 2011 ucsd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameObject.h"


@interface GameCharacter : GameObject {
    int _characterHealth; 
    CharacterStates _characterState;    
    CharacterStates _lastCharacterState;
}

-(int)getWeaponDamage;
    
@property (readwrite) int characterHealth; 
@property (readwrite) CharacterStates characterState;
@property (readwrite) CharacterStates lastCharacterState;
        

@end
