//
//  PTStopsForRouteRequest.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 4/4/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

extern const NSString *kRouteIdentifierB9;
extern const NSString *kRouteIdentifierX27;

@interface PTStopsForRouteRequest : NSURLRequest

+ (NSURLRequest *)requestWithRouteID:(NSString *)identifier;
+ (NSURLRequest *)sampleRequest;

@end
