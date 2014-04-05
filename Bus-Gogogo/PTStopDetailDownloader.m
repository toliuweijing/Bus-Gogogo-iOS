//
//  PTStopDetailDownloader.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 3/23/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTStopDetailDownloader.h"
#import "PTStopMonitoringRequest.h"
#import <CoreLocation/CoreLocation.h>
#import "MTADataModelAdaptors.h"
#import "PTMonitoredVehicleJourney.h"

@interface PTStopDetailDownloader () <NSURLSessionDataDelegate>

@property (nonatomic, strong) NSURLSession *session;

@property (nonatomic, strong) PTStop *stop;

@property (nonatomic, strong) stop_detail_downloader_completion_handler completionHandler;

@end

@implementation PTStopDetailDownloader

- (instancetype)initWithStop:(PTStop *)stop;
{
  if (self = [super init]) {
    _stop = stop;
    
    // init session
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.requestCachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    _session = [NSURLSession sessionWithConfiguration:config
                                             delegate:self
                                        delegateQueue:[NSOperationQueue mainQueue]];
  }
  return self;
}

- (void)downloadWithCompletionHandler:(stop_detail_downloader_completion_handler)completionHandler
{
  self.completionHandler = completionHandler;
  [[self.session dataTaskWithRequest:[PTStopMonitoringRequest sampleRequest]] resume];
}

+ (NSArray *)PTVehcileJourneysInMTAResponse:(MTAResponse *)mtaResponse
{
  // parse into stop visit
  NSArray *stopVisits = [[mtaResponse.Siri.ServiceDelivery.StopMonitoringDelivery firstObject] MonitoredStopVisit];
  
  // parse into vehcile journeys
  NSMutableArray *collection = [[NSMutableArray alloc] initWithCapacity:stopVisits.count];
  [stopVisits enumerateObjectsUsingBlock:^(MTAMonitoredStopVisit *stopVisit, NSUInteger idx, BOOL *stop) {
    PTMonitoredVehicleJourney *ptVehcileJourney = [[PTMonitoredVehicleJourney alloc] initWithMTACounterPart:stopVisit.MonitoredVehicleJourney];
    [collection addObject:ptVehcileJourney];
  }];
  return collection;
}

- (MTAResponse *)_mtaResponseFromRawData:(NSData *)rawData
{
  NSDictionary *json = [NSJSONSerialization JSONObjectWithData:rawData options:0 error:nil];
  NSLog(@"%@",json);
  return [[MTAResponse alloc] initWithDictionary:json];
}

#pragma mark -
#pragma mark NSURLSessionDataDelegate

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
  MTAResponse *mta = [self _mtaResponseFromRawData:data];
  NSArray *vehcileJourneys = [PTStopDetailDownloader PTVehcileJourneysInMTAResponse:mta];
  self.completionHandler(vehcileJourneys, nil);
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
  assert(error == nil);
}

@end
