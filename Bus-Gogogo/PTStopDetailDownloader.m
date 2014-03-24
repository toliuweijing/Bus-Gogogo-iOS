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

- (void)downloadWithSuccessBlock:(stop_detail_downloader_success_block)successBlock
                    failureBlock:(stop_detail_downloader_failure_block)failureBlock
{
  [[self.session dataTaskWithRequest:[PTStopMonitoringRequest sampleRequest] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSArray *locations = [self parseResponse:json];
    dispatch_async(dispatch_get_main_queue(), ^{
      successBlock(locations);
    });
  }] resume];
}

// return all locations parsed from response
- (NSArray *)parseResponse:(NSDictionary *)response
{
  NSMutableArray *locations = [[NSMutableArray alloc] init];
  const NSString *kSiri = @"Siri";
  const NSString *kServiceDelivery = @"ServiceDelivery";
  const NSString *kStopMonitoringDelivery = @"StopMonitoringDelivery";
  const NSString *kMonitoredStopVisit = @"MonitoredStopVisit";
  NSArray *array = [response[kSiri][kServiceDelivery][kStopMonitoringDelivery] firstObject][kMonitoredStopVisit];
  [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
    const NSString *kMonitoredVehicleJourney = @"MonitoredVehicleJourney";
    const NSString *kVehicleLocation = @"VehicleLocation";
    const NSString *kLatitude = @"Latitude";
    const NSString *kLongitude = @"Longitude";
    NSDictionary *locationDict = obj[kMonitoredVehicleJourney][kVehicleLocation];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:[locationDict[kLatitude] doubleValue]
                                                      longitude:[locationDict[kLongitude] doubleValue]];
    [locations addObject:location];
  }];
  return locations;
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse {
  return nil;
}

@end
