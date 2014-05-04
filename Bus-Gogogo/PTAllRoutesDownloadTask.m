//
//  PTAllRoutesDownloadTask.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 5/3/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "OBADataModel.h"
#import "PTRoute.h"
#import "PTAllRoutesDownloadTask.h"

@implementation PTAllRoutesDownloadTask
{
  NSURLSession *_session;
  void (^_completionHandler)(NSArray *routes, NSError *error);
}


+ (PTAllRoutesDownloadTask *)scheduledTaskWithCompletionHandler:(void (^)(NSArray *routes, NSError *error))completionHandler
{
  PTAllRoutesDownloadTask *task = [[PTAllRoutesDownloadTask alloc] initWithCompletionHandler:completionHandler];
  [task _start];
  return task;
}

- (instancetype)initWithCompletionHandler:(void (^)(NSArray *routes, NSError *error))completionHandler
{
  assert(completionHandler);
  if (self = [super init]) {
    _completionHandler = completionHandler;
    _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
  }
  return self;
}

- (void)_start
{
  NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://bustime.mta.info/api/where/routes-for-agency/MTA%20NYCT.json?key=cfb3c75b-5a43-4e66-b7f8-14e666b0c1c1"]];
  id __weak weakSelf = self;
  [[_session dataTaskWithRequest:request
               completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                 [weakSelf _dataTaskDidCallbackWithData:data
                                               response:response
                                                  error:error];
               }] resume];
}

- (void)_dataTaskDidCallbackWithData:(NSData *)data
                            response:(NSURLResponse *)response
                               error:(NSError *)error
{
  if (error) {
    _completionHandler(nil, error);
  } else {
    NSArray *routes = [self _routesFromData:data];
    _completionHandler(routes, error);
  }
}

- (NSArray *)_routesFromData:(NSData *)data
{
  NSError *error;
  NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
  assert(!error);

  NSArray *list = json[@"data"][@"list"];
  
  NSMutableArray *collection = [[NSMutableArray alloc] init];
  for (NSDictionary *dict in list) {
    OBARoute *obaRoute = [[OBARoute alloc] initWithDictionary:dict];
    PTRoute *ptRoute = [[PTRoute alloc] initWithOBACounterPart:obaRoute];
    [collection addObject:ptRoute];
  }
  return [collection copy];
}

@end
