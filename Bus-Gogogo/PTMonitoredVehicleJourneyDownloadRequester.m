//
//  PTMonitoredVehicleJourneyDownloadRequester.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 6/8/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTMonitoredVehicleJourneyDownloadRequester.h"
#import "PTMonitoredVehicleJourney.h"
#import "MTADataModels.h"

@implementation PTMonitoredVehicleJourneyDownloadRequester
{
  NSString *_routeId;
}

- (instancetype)initWithRouteId:(NSString *)routeId
{
  if (self = [super init]) {
    _routeId = routeId;
  }
  return self;
}

- (NSURLRequest *)request
{
  _routeId = [_routeId stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
  NSString *format = @"http://bustime.mta.info/api/siri/vehicle-monitoring.json?key=cfb3c75b-5a43-4e66-b7f8-14e666b0c1c1&LineRef=%@";
  NSString *base = [NSString stringWithFormat:format, _routeId];
  NSURL *url = [NSURL URLWithString:base];
  return [NSURLRequest requestWithURL:url];
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
  
  NSMutableArray *collection = [[NSMutableArray alloc] init];
  
  
  MTAVehicleMonitoringDelivery *vehcileMonitoringDelivery = mta.Siri.ServiceDelivery.VehicleMonitoringDelivery.firstObject;
  NSArray *vehicleActivites = vehcileMonitoringDelivery.VehicleActivity;
  for (MTAVehicleActivity *activity in vehicleActivites) {
    MTAMonitoredVehicleJourney *journey = activity.MonitoredVehicleJourney;
    [collection addObject:[[PTMonitoredVehicleJourney alloc] initWithMTACounterPart:journey]];
  }
  return collection;
}

@end
