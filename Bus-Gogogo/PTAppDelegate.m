//
//  PTAppDelegate.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 3/22/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTAppDelegate.h"

@implementation PTAppDelegate

- (BOOL)is4Inch
{
  return [[UIScreen mainScreen] bounds].size.height == 568;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  //Register and allow the push of notification
  [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge)];
  
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
  [application setStatusBarStyle:UIStatusBarStyleLightContent];
  
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


/**
 *  This function is used to get a clientID for app (From default or register)
 *
 *  @param pushToken the new apns token
 */
-(void) getTheClientIDForServer:(NSString *)pushToken
{
    /**
     *  check if the default has got a ID
     */
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"clientID"]==nil)
    {
        /**
         *  If we don't find one the clientID in the user default
         */
        self.clientID=nil;
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            NSString *format =
            @"http://ec2-54-88-127-149.compute-1.amazonaws.com:85/RegisterByToken?"
            "token=%@";
            NSString *urlString =
            [NSString
             stringWithFormat:format,
             pushToken];
            urlString = [urlString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
            NSData* data = [NSData dataWithContentsOfURL:
                            [NSURL URLWithString:urlString]];
            NSError *error;
            NSDictionary *JSONResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            self.clientID=JSONResponse[@"ClientID"];
            NSLog(@"clientID:%@",self.clientID);
            [defaults setObject:self.clientID forKey:@"clientID"];
        });
        
    }
    else
    {
        /**
         *  if we found clientID in user default
         */
        self.clientID=[defaults objectForKey:@"clientID"];
        NSLog(@"Retrieve the old clientID:%@",self.clientID);
        //check if the push token change
        NSString *oldPushToken=[defaults objectForKey:@"pushToken"];
        if (oldPushToken!=pushToken)
        {
            /**
             *  if the old push token is not the same with the new push token we get
             */
            dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                NSString *format =
                @"http://ec2-54-88-127-149.compute-1.amazonaws.com:85/UpdateToken?"
                "clientid=%@&"
                "token=%@";
                NSString* urlString=[NSString
                                     stringWithFormat:format,self.clientID,
                                     pushToken];
                urlString = [urlString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
                NSData* data = [NSData dataWithContentsOfURL:
                                [NSURL URLWithString:urlString]];
                NSError *error;
                /**
                 *  need to check if the json is success or not, but do need to negotiate with Jim about the return value. So mark it as TODO
                 */
                NSDictionary *JSONResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                /**
                 *  Store the new key into user default
                 */
                [defaults setObject:pushToken forKey:@"pushToken"];
                
            });
        }
        
    }

}

- (void)application:(UIApplication*)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    
    //Get the push token
    NSString *tokenStr = [deviceToken description];
    NSString *pushToken = [[tokenStr stringByReplacingOccurrencesOfString:@"" withString:@""]stringByReplacingOccurrencesOfString:@" " withString:@""];
    //the push token is something like <edfsdfsfxxxxxxx>,we need to move the first letter and the last letter
    pushToken=[pushToken substringWithRange:NSMakeRange(1,pushToken.length-2)];
    NSLog(@"pushToken:%@",pushToken);
    [self getTheClientIDForServer:pushToken];
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err
{
    /**
     *  The app fail to register the pushtoken, probably because of the simulator running.
     */
    NSString *str = [NSString stringWithFormat: @"Error: %@", err];
    NSLog(@"Fail to register the APNS push service:%@",str);
    /**
     *  Try to use the push token for my own phone for testing
     */
    NSString *testPushToken=@"ebe293a6e1651defb50cd4a4a6f2f91f250afba1584987f47d0de8209a7586b4";
    [self getTheClientIDForServer:testPushToken];
}

@end
