//
//  GameObject.h
//  yan_proto
//
//  Created by Steve Han on 8/31/11.
//  Copyright 2011 ucsd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Constants.h"
#import "CommonProtocols.h"
#import "Scenemanager.h"
#import "BGLayer.h"


@interface GameObject : CCSprite {
    BOOL isActive;
    BOOL reactsToScreenBoundaries;
    CGSize screenSize;
    GameObjectType gameObjectType;
    NSMutableArray* cornerVertices;
    NSMutableArray* cornerVerticesX;
    NSMutableArray* cornerVerticesY;
    NSDictionary* movementData;
}

@property (readwrite) BOOL isActive;
@property (readwrite) BOOL reactsToScreenBoundaries;
@property (readwrite) CGSize screenSize;
@property (readwrite) GameObjectType gameObjectType;

- (void) changeState: (CharacterStates) newState;
- (void) changeState: (CharacterStates) newState heading: (CharacterHeading) newHeading;

- (void) updateStateWithDeltaTime: (ccTime) deltaTime andListOfGameObjects: (CCArray*) listOfGameObjects;
- (CGRect) adjustedBoundingBox;
- (CCAnimation*) loadPlistForAnimationWithName: (NSString *) animationName andClassName: (NSString *) className;

- (void) findNextPosition: (NSDictionary*) dict;

@end
