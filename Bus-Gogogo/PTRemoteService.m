//
//  PTRemoteService.m
//  Bus-Gogogo
//
//  Created by Developer on 6/28/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTRemoteService.h"
#import "PTRemoteReminderRequest.h"

@interface PTRemoteService ()
{
  NSString *_pushToken;
}

@end

@implementation PTRemoteService

- (instancetype)initWithPushToken:(NSString *)pushToken
{
  if (self = [super init]) {
    _pushToken = pushToken;
    [self getTheClientIDForServer:pushToken];
  }
  return self;
}

- (void)registerRemoteReminder:(PTRemoteReminderRequest *)request
             completionHandler:(void (^)(NSURLResponse *response, NSError *error))completionHandler
{
  [NSURLConnection
   sendAsynchronousRequest:[request urlRequest]
   queue:[NSOperationQueue mainQueue]
   completionHandler:
   ^(NSURLResponse *response, NSData *result, NSError *error){
     NSLog(@"%@",response);
     completionHandler(response, error);
   }];
}


/**
 *  This function is used to get a clientID for app (From default or register)
 *
 *  @param pushToken the new apns token
 */
-(void)getTheClientIDForServer:(NSString *)pushToken
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
    _clientID=nil;
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
      _clientID=JSONResponse[@"ClientID"];
      NSLog(@"clientID:%@", _clientID);
      [defaults setObject:_clientID forKey:@"clientID"];
    });
    
  }
  else
  {
    /**
     *  if we found clientID in user default
     */
    _clientID=[defaults objectForKey:@"clientID"];
    NSLog(@"Retrieve the old clientID:%@",_clientID);
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
                             stringWithFormat:format,_clientID,
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

@end
