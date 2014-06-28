//
//  PTRemoteService.m
//  Bus-Gogogo
//
//  Created by Developer on 6/28/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTRemoteService.h"
#import "PTRemoteReminderRequest.h"

@implementation PTRemoteService

+ (PTRemoteService *)sharedService
{
  static PTRemoteService *instance;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [[PTRemoteService alloc] init];
  });
  return instance;
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

@end
