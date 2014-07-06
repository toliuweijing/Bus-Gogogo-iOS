//
//  PTRemoteReminderRequest.h
//  Bus-Gogogo
//
//  Created by Developer on 6/28/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTStopProtocol.h"
#import "PTRouteProtocol.h"

@interface PTRemoteReminderRequest : NSObject

- (NSURLRequest *)urlRequest;

// temporary helper to build request
+ (PTRemoteReminderRequest *)requestWithStop:(id<PTStopProtocol>)stop
                                       route:(id<PTRouteProtocol>)route
                                   direction:(int)direction
                                arrivalRadar:(int)arrivalRadar
                                    clientID:(NSString *)clientID;

@end
