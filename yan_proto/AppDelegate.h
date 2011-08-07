//
//  AppDelegate.h
//  yan_proto
//
//  Created by Steve Han on 8/6/11.
//  Copyright ucsd 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
