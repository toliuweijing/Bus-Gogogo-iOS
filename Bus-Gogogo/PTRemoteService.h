//
//  PTRemoteService.h
//  Bus-Gogogo
//
//  Created by Developer on 6/28/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

@class PTRemoteReminderRequest;

@interface PTRemoteService : NSObject

- (instancetype)initWithPushToken:(NSString *)pushToken;

- (void)registerRemoteReminder:(PTRemoteReminderRequest *)request
             completionHandler:(void (^)(NSURLResponse *response, NSError *error))completionHandler;

@property (nonatomic, strong) NSString *clientID;

@end
