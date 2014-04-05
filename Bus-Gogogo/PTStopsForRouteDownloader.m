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

@interface PTStopsForRouteDownloader () <NSURLSessionDelegate>

@property (nonatomic, strong) NSURLSession *session;

@end

@implementation PTStopsForRouteDownloader

- (instancetype)init
{
  if (self = [super init]) {
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.requestCachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    _session = [NSURLSession sessionWithConfiguration:config
                                             delegate:self
                                        delegateQueue:[NSOperationQueue mainQueue]];
  }
  return self;
}

- (void)startDownload
{
  [[self.session dataTaskWithRequest:[PTStopsForRouteRequest sampleRequest]] resume];
}

#pragma mark -
#pragma mark NSURLSessionDataDelegate

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
  NSDictionary *JSONResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
  OBAResponse *oba = [[OBAResponse alloc] initWithDictionary:JSONResponse];
  
  NSMutableArray *ptStops = [[NSMutableArray alloc] initWithCapacity:oba.Data.Stops.count];
  for (OBAStop *obaStop in oba.Data.Stops) {
    [ptStops addObject:[[PTStop alloc] initWithOBAStop:obaStop]];
  }
  
  // ----
  OBAStopGrouping *stopGrouping = oba.Data.StopGroupings.firstObject;
  OBAStopGroup *stopGroup = stopGrouping.StopGroups.firstObject;
  OBAPolyline *polyline = stopGroup.Polylines.lastObject;
  
  NSArray *points = [self parse:polyline];
  
  PTStopGroup *stopGroup = [[PTStopGroup alloc] init];
  route.stops = ptStops;
  route.polylinePoints = [points copy];
  [self.delegate downloader:self didReceiveStopGroup:stopGroup];
}

- (NSArray *)parse:(OBAPolyline *)polyline
{
  NSArray *locations = [self decodePolyLine:polyline.Points];
  return locations;
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
  assert(error == nil);
}

@end
