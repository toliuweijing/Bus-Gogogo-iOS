//
//  PTStopsForRouteRequest.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 4/4/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTStopsForRouteRequest.h"

@implementation PTStopsForRouteRequest

+ (NSURLRequest *)sampleRequest
{
  NSString *base = @"http://bustime.mta.info/api/where/stops-for-route/MTA%20NYCT_B9.json?key=cfb3c75b-5a43-4e66-b7f8-14e666b0c1c1";
  return [NSURLRequest requestWithURL:[NSURL URLWithString:base]];
}

@end
