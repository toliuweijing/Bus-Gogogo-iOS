//
//  PTStopsForRouteDownloader.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 4/4/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTStopsForRouteDownloader.h"
#import "PTStopsForRouteRequest.h"
#import "OBADataModel.h"
#import "PTStop.h"
#import "PTStore.h"

@interface PTStopsForRouteDownloader () <NSURLSessionDelegate>

@property (nonatomic, strong) NSURLSession *session;

@property (nonatomic, strong) NSString *routeID;

@end

@implementation PTStopsForRouteDownloader

- (instancetype)initWithRouteIdentifier:(NSString *)routeID delegate:(id<PTStopsForRouteDownloaderDelegate>)delegate;
{
  if (self = [super init]) {
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.requestCachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    _session = [NSURLSession sessionWithConfiguration:config];
    _routeID = routeID;
    _delegate = delegate;
    [self _startDownload];
  }
  return self;
}

- (void)_startDownload
{
  NSURLRequest *request = [PTStopsForRouteRequest requestWithRouteID:self.routeID];
  [[self.session dataTaskWithRequest:request
                  completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                    NSArray *stopGroups = [self stopGroupsFromData:data];
                    dispatch_async(dispatch_get_main_queue(), ^{
                      [self.delegate downloader:self didReceiveStopGroups:stopGroups];
                    });
  }] resume];
}

- (NSArray *)stopGroupsFromData:(NSData *)data
{
  NSError *error;
  NSDictionary *JSONResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
  assert(!error);
  
  OBAResponse *oba = [[OBAResponse alloc] initWithDictionary:JSONResponse];
  
  // populate results into global store
  [[PTStore sharedStore] populateWithOBAResponse:oba];
 
  OBAStopGrouping *stopGrouping = oba.Data.StopGroupings.firstObject;
  OBAStopGroup *stopGroupA = stopGrouping.StopGroups.firstObject;
  OBAStopGroup *stopGroupB = stopGrouping.StopGroups.lastObject;
  NSArray *ptStopGroups = @[[PTStopGroup stopGroupFromOBACounterPart:stopGroupA],
                            [PTStopGroup stopGroupFromOBACounterPart:stopGroupB]];
  return ptStopGroups;
}

@end
