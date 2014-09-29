//
//  PTStopMonitoringDownloadRequester.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 6/14/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTStopMonitoringDownloadRequester.h"
#import "PTMonitoredVehicleJourney.h"
#import "MTADataModels.h"

@interface PTStopMonitoringDownloadRequester ()
{
  NSString *_stopId;
  NSString *_routeId;
  NSArray *_monitoredJourneys;
}

@end

@implementation PTStopMonitoringDownloadRequester

+ (instancetype)sampleB9EightAv
{
  return [[PTStopMonitoringDownloadRequester alloc]
          initWithStopId:@"MTA_301008"
          routeId:@"MTA NYCT_B9"];
}

+ (instancetype)sampleB9ShoreRd
{
  return [[PTStopMonitoringDownloadRequester alloc]
          initWithStopId:@"MTA_300071"
          routeId:@"MTA NYCT_B9"];
}

- (instancetype)initWithStopId:(NSString *)stopId
                       routeId:(NSString *)routeId
{
  if (self = [super init]) {
    _stopId = stopId;
    _routeId = routeId;
  }
  return self;
}

- (NSURLRequest *)request
{
  assert(_stopId);
  NSString *format =
  @"http://bustime.mta.info/api/siri/stop-monitoring.json?"
  "key=cfb3c75b-5a43-4e66-b7f8-14e666b0c1c1&"
  "&MonitoringRef=%@";
  NSString *urlString = [NSString stringWithFormat:format, _stopId];
  urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"LineRef=%@", _routeId]];
  urlString = [urlString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
  return [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
}

- (void)parseData:(NSData *)data
{
  _monitoredJourneys = [self vehicleJourneysFromData:data];
}


- (NSArray *)monitoredJourneys
{
  return _monitoredJourneys;
}

- (NSArray *)vehicleJourneysFromData:(NSData *)data
{
  NSError *error;
  NSDictionary *JSONResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
  assert(!error);
  
  MTAResponse *mta = [[MTAResponse alloc] initWithDictionary:JSONResponse];
  
  MTAStopMonitoringDelivery *delivery = mta.Siri.ServiceDelivery.StopMonitoringDelivery.firstObject;
  NSMutableArray *journeys = [NSMutableArray new];
  
  for (MTAMonitoredStopVisit *visit in delivery.MonitoredStopVisit) {
    PTMonitoredVehicleJourney *journey =
    [[PTMonitoredVehicleJourney alloc]
     initWithMTACounterPart:visit.MonitoredVehicleJourney];
    [journeys addObject:journey];
  }
  return journeys;
}

@end
