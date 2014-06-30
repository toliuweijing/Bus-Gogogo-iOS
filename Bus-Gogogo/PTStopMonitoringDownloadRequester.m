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
  int _direction;
}

@end

@implementation PTStopMonitoringDownloadRequester

+ (instancetype)sampleB9EightAv
{
  return [[PTStopMonitoringDownloadRequester alloc]
          initWithStopId:@"MTA_301008"
          routeId:@"MTA NYCT_B9"
          direction:1];
}

+ (instancetype)sampleB9ShoreRd
{
  return [[PTStopMonitoringDownloadRequester alloc]
          initWithStopId:@"MTA_300071"
          routeId:@"MTA NYCT_B9"
          direction:1];
}

- (instancetype)initWithStopId:(NSString *)stopId
                       routeId:(NSString *)routeId
                     direction:(int)direction
{
  if (self = [super init]) {
    _stopId = stopId;
    _routeId = routeId;
    _direction = direction;
  }
  return self;
}

- (NSURLRequest *)request
{
  NSString *format =
  @"http://bustime.mta.info/api/siri/stop-monitoring.json?"
  "key=cfb3c75b-5a43-4e66-b7f8-14e666b0c1c1&"
  "LineRef=%@&"
  "MonitoringRef=%@&"
  "DirectionRef=%d";
  NSString *urlString = [NSString stringWithFormat:format, _routeId, _stopId, _direction];
  urlString = [urlString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
  return [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
}

- (id)parseData:(NSData *)data
{
  return [self vehicleJourneysFromData:data];
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
