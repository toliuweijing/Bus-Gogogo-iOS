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
    _session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
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
  [[self.session dataTaskWithRequest:request] resume];
}

#pragma mark -
#pragma mark NSURLSessionDataDelegate

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
  NSDictionary *JSONResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
  MTAResponse *mta = [[MTAResponse alloc] initWithDictionary:JSONResponse];
  
  NSMutableArray *collection = [[NSMutableArray alloc] init];
  
  
  MTAVehicleMonitoringDelivery *vehcileMonitoringDelivery = mta.Siri.ServiceDelivery.VehicleMonitoringDelivery.firstObject;
  NSArray *vehicleActivites = vehcileMonitoringDelivery.VehicleActivity;
  for (MTAVehicleActivity *activity in vehicleActivites) {
    MTAMonitoredVehicleJourney *journey = activity.MonitoredVehicleJourney;
    [collection addObject:[[PTMonitoredVehicleJourney alloc] initWithMTACounterPart:journey]];
  }
  [self.delegate downloader:self didReceiveVehicleJourneys:collection];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
  assert(error == nil);
}

@end
