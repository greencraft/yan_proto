//
//  CommonProtocols.h
//  yan_proto
//
//  Created by Steve Han on 8/31/11.
//

typedef enum { 
    kStateMoving,
    //kStateMovingDown,
    //kStateMovingLeft,
    //kStateMovingRight,
    kStateIdle,
    //kStateFacingDownIdle,
    //kStateFacingLeftIdle,
    //kStateFacingRightIdle,
    
    kStateDead,
    kStateTakingDamage
} CharacterStates;

typedef enum {
    kNorth, //0
    kSouth, //1
    kEast, //2
    kWest, //3
    kNorthEast,
    kNorthWest,
    kSouthEast,
    kSouthWest,
    kNeutral
} CharacterHeading;

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








