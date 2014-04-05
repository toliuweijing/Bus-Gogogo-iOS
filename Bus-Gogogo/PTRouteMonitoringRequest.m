//
//  PTRouteMonitoringRequest.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 4/4/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTRouteMonitoringRequest.h"

@implementation PTRouteMonitoringRequest

+ (NSURLRequest *)sampleRequest
{
  NSString *base = @"http://bustime.mta.info/api/siri/vehicle-monitoring.json?key=cfb3c75b-5a43-4e66-b7f8-14e666b0c1c1&LineRef=MTA%20NYCT_B9";
  return [NSURLRequest requestWithURL:[NSURL URLWithString:base] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:10];
}

@end
