//
//  PTAppDelegate.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 3/22/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTAppDelegate : UIResponder <UIApplicationDelegate>

+ (PTAppDelegate *)mainDelegate;

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSString *clientID;

@end
