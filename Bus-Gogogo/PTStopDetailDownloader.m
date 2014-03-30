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

@interface PTStopDetailDownloader () <NSURLConnectionDelegate>

@property (nonatomic, strong) NSURLSession *session;

@property (nonatomic, strong) PTStop *stop;

@end

@implementation PTStopDetailDownloader

- (instancetype)initWithStop:(PTStop *)stop;
{
  if (self = [super init]) {
    _stop = stop;
    
    // init session
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    _session = [NSURLSession sessionWithConfiguration:config];
  }
  return self;
}

- (void)downloadWithCompletionHandler:(stop_detail_downloader_completion_handler)completionHandler
{
  [[self.session dataTaskWithRequest:[PTStopMonitoringRequest sampleRequest]
                   completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                     // parse into property list.
                     NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                     NSLog(@"%@", json);
                     
                     // parse into mta response.
                     MTAResponse *mta = [[MTAResponse alloc] initWithDictionary:json];
                     
                     NSArray *vehcileJourneys = [PTStopDetailDownloader PTVehcileJourneysInMTAResponse:mta];
                     
                     // completion callback
                     dispatch_async(dispatch_get_main_queue(), ^{
                       completionHandler(vehcileJourneys, error);
                     });
                   }] resume];
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

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse {
  return nil;
}

@end
