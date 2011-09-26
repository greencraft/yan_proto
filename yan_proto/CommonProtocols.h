//
//  CommonProtocols.h
//  yan_proto
//
//  Created by Steve Han on 8/31/11.
//

typedef enum { 
    kStateMovingUp,
    kStateMovingDown,
    kStateMovingLeft,
    kStateMovingRight,
    kStateFacingUpIdle,
    kStateFacingDownIdle,
    kStateFacingLeftIdle,
    kStateFacingRightIdle,
    
    kStateDead,
    kStateTakingDamage
} CharacterStates;

typedef enum { 
    kObjectTypeNone, 
    kPowerUpTypeHealth, 
    kPowerUpTypeMallet, 
    kEnemyTypeRadarDish, 
    kEnemyTypeSpaceCargoShip, 
    kEnemyTypeAlienRobot, 
    kEnemyTypePhaser,
    kYanType
} GameObjectType;

@protocol MainLayerDelegate 

-(void)createObjectOfType:(GameObjectType)objectType
               withHealth:(int)initialHealth 
               atLocation:(CGPoint)spawnLocation 
               withZValue:(int)ZValue;

@end








