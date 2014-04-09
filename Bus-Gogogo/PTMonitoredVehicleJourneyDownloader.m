//
//  PTMonitoredVehicleJourneyDownloader.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 4/6/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTMonitoredVehicleJourneyDownloader.h"
#import "MTADataModels.h"

@interface PTMonitoredVehicleJourneyDownloader () <NSURLSessionDelegate>

@property (nonatomic, strong) NSURLSession *session;

@property (nonatomic, strong) NSString *routeIdentifier;

@end

@implementation PTMonitoredVehicleJourneyDownloader

- (instancetype)initWithRouteIdentifier:(NSString *)routeID
{
  if (self = [super init]) {
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    _session = [NSURLSession sessionWithConfiguration:config];
    _routeIdentifier = routeID;
  }
  return self;
}

-(void)startDownload
{
  self.routeIdentifier = [self.routeIdentifier stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
  NSString *format = @"http://bustime.mta.info/api/siri/vehicle-monitoring.json?key=cfb3c75b-5a43-4e66-b7f8-14e666b0c1c1&LineRef=%@";
  NSString *base = [NSString stringWithFormat:format, self.routeIdentifier];
  NSURL *url = [NSURL URLWithString:base];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];
  [[self.session dataTaskWithRequest:request
                   completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                     NSArray *journeys = [self vehicleJourneysFromData:data];
                     dispatch_async(dispatch_get_main_queue(), ^{
                       [self.delegate downloader:self didReceiveVehicleJourneys:journeys];
                     });
  }] resume];
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
