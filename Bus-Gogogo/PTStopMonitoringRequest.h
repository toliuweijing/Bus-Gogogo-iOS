//
//  PTMonitoringRequest.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 3/23/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

struct PTStopMonitoringRequestParamNames {
  // your MTA Bus Time developer API key (required).
  const char *key;
  // the GTFS stop ID of the stop to be monitored (required)
  const char *monitoringRef;
  // a filter by 'fully qualified' route name, (e.g. MTA NYCT_B63).
  const char *lineRef;
} PTStopMonitoringRequestParamNames;

@interface PTStopMonitoringRequest : NSURLRequest

/**
 Designated initalizer, additional query params can be specified in "extra".
 */
- (instancetype)initWithMonitoringRef:(NSString *)monitoringRef extra:(NSDictionary *)extra;

+ (PTStopMonitoringRequest *)sampleRequest;

@end
