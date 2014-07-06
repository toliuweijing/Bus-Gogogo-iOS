//
//  PTAppDelegate.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 3/22/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PTRemoteService;

@interface PTAppDelegate : UIResponder <UIApplicationDelegate>

+ (PTAppDelegate *)mainDelegate;

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) PTRemoteService *remoteService;

@end
