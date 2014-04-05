//
//  PTMonitoringRequest.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 3/23/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTStopMonitoringRequest.h"

static NSString *const kSIRIKey = @"cfb3c75b-5a43-4e66-b7f8-14e666b0c1c1";

struct PTStopMonitoringRequestParamNames PTStopMonitoringRequestParamNames = {
  .key = "key",
  .monitoringRef = "MonitoringRef",
  .lineRef = "LineRef",
};

@interface PTStopMonitoringRequest ()

@end

@implementation PTStopMonitoringRequest

- (instancetype)initWithMonitoringRef:(NSString *)monitoringRef extra:(NSDictionary *)extra
{
  assert(NO);
  return self;
}

+ (PTStopMonitoringRequest *)sampleRequest
{
//  NSString *base = @"http://bustime.mta.info/api/siri/stop-monitoring.json?key=cfb3c75b-5a43-4e66-b7f8-14e666b0c1c1&LineRef=MTA%20NYCT_B9&MonitoringRef=300071";
  NSString *base = @"http://bustime.mta.info/api/siri/stop-monitoring.json?key=cfb3c75b-5a43-4e66-b7f8-14e666b0c1c1&MonitoringRef=300071";
  return [NSURLRequest requestWithURL:[NSURL URLWithString:base] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:10];
}
          
@end
