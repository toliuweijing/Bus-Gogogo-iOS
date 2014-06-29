//
//  PTAppDelegate.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 3/22/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTAppDelegate.h"
#import "PTMainScreenViewController.h"

@implementation PTAppDelegate

- (BOOL)is4Inch
{
  return [[UIScreen mainScreen] bounds].size.height == 568;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  //Register and allow the push of notification
  [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
  
  // 2. load storyboard based on screen size.
  UIStoryboard *mainStoryboard = nil;
  if (![self is4Inch]) {
    mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
  } else {
    mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard_4inch" bundle:nil];
  }
  
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  self.window.rootViewController = [mainStoryboard instantiateInitialViewController];
  [self.window makeKeyAndVisible];
  
  return YES;
  return YES;
}
      

- (void)applicationWillResignActive:(UIApplication *)application
{
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication*)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken {
    
    //Get the push token
    NSString *tokenStr = [deviceToken description];
    NSString *pushToken = [[tokenStr stringByReplacingOccurrencesOfString:@"" withString:@""]stringByReplacingOccurrencesOfString:@" " withString:@""];
    //the push token is something like <edfsdfsfxxxxxxx>,we need to move the first letter and the last letter
    self.pushToken=[pushToken substringWithRange:NSMakeRange(1,pushToken.length-2)];
    NSLog(@"pushToken:%@",self.pushToken);
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    
    NSString *str = [NSString stringWithFormat: @"Error: %@", err];
    NSLog(@"Fail to register the APNS push service:%@",str);
}

@end
