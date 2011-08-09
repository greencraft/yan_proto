//
//  Scenemanager.h
//  yan prototype
//
//  Created by Steve Han on 8/3/11.
//  Copyright 2011 ucsd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MainLayer.h"
#import "BGLayer.h"

@interface Scenemanager : CCScene {
    
        CGPoint _location;
}

@property (nonatomic) CGPoint location;

@end
