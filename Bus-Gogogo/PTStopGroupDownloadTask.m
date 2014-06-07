//
//  PTStopGroupDownloadTask.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 6/7/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTStopGroupDownloadTask.h"

#import "OBADataModel.h"
#import "PTStore.h"
#import "PTStopGroup.h"

@interface PTStopGroupDownloadTask ()
{
  NSURLSession *_session;
  StopGroupCallback _callback;
  NSString *_routeId;
}

@end

@implementation PTStopGroupDownloadTask

+ (PTStopGroupDownloadTask *)scheduledTaskWithRouteId:(NSString *)routeId
                                             callback:(StopGroupCallback)callback
{
  PTStopGroupDownloadTask *task = [[PTStopGroupDownloadTask alloc]
                                   initWithRouteId:routeId
                                   callback:callback];
  
  [task _start];
  return task;
}

- (instancetype)initWithRouteId:(NSString *)routeId
                       callback:(StopGroupCallback)callback
{
  if (self = [super init]) {
    _routeId = routeId;
    _callback = callback;
  }
  return self;
}

- (void)_start
{
  NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
  config.requestCachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
  _session = [NSURLSession sessionWithConfiguration:config];
  
  __weak id weakSelf = self;
  [[_session dataTaskWithRequest:[self _request]
               completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                 [weakSelf _dataTaskDidCallbackWithData:data response:response error:error];
               }] resume];
}

- (void)_dataTaskDidCallbackWithData:(NSData *)data response:(NSURLResponse *)response error:(NSError *)error
{
  NSArray *stopGroups;
  if (error == nil) {
    stopGroups = [self _stopGroupsFromData:data];
  }
  dispatch_async(dispatch_get_main_queue(), ^{
    _callback(stopGroups, error);
  });
}

- (NSArray *)_stopGroupsFromData:(NSData *)data
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

- (NSURLRequest *)_request
{
  NSString *identifier = [_routeId stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
  NSString *format = @"http://bustime.mta.info/api/where/stops-for-route/%@.json?key=c6e4158f-c556-44ce-9048-597ec09c5d46";
  NSString *base = [NSString stringWithFormat:format, identifier];
  return [NSURLRequest requestWithURL:[NSURL URLWithString:base]];
}

@end
