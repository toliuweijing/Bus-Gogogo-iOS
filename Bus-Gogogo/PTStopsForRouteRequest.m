//
//  PTStopsForRouteRequest.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 4/4/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTStopsForRouteRequest.h"

const NSString *kRouteIdentifierB9 = @"MTA NYCT_B9";
const NSString *kRouteIdentifierX27 = @"MTA NYCT_X27";

@implementation PTStopsForRouteRequest

+ (NSURLRequest *)requestWithRouteID:(NSString *)identifier
{
  identifier = [identifier stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
//  NSString *format = @"http://bustime.mta.info/api/where/stops-for-route/%@.json?key=cfb3c75b-5a43-4e66-b7f8-14e666b0c1c1";
  NSString *format = @"http://bustime.mta.info/api/where/stops-for-route/%@.json?key=c6e4158f-c556-44ce-9048-597ec09c5d46";
  NSString *base = [NSString stringWithFormat:format, identifier];
  return [NSURLRequest requestWithURL:[NSURL URLWithString:base]];
}

+ (NSURLRequest *)sampleRequest
{
//  NSString *base = @"http://bustime.mta.info/api/where/stops-for-route/MTA%20NYCT_B9.json?key=cfb3c75b-5a43-4e66-b7f8-14e666b0c1c1";
  NSString *base = @"http://bustime.mta.info/api/where/stops-for-route/MTA%20NYCT_B9.json?key=c6e4158f-c556-44ce-9048-597ec09c5d46";
  return [NSURLRequest requestWithURL:[NSURL URLWithString:base]];
}

@end
