//
//  PTStopGroupDownloadRequester.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 6/8/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTStopGroupDownloadRequester.h"
#import "OBADataModel.h"
#import "PTStore.h"
#import "PTStopGroup.h"

@interface PTStopGroupDownloadRequester ()
{
  NSString *_routeId;
  OBAResponse *_response;
}

@end

@implementation PTStopGroupDownloadRequester

- (instancetype)initWithRouteId:(NSString *)routeId
{
  if (self = [super init]) {
    _routeId = routeId;
  }
  return self;
}

- (NSURLRequest *)request
{
  NSString *identifier = [_routeId stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
  NSString *format = @"http://bustime.mta.info/api/where/stops-for-route/%@.json?key=c6e4158f-c556-44ce-9048-597ec09c5d46";
  NSString *base = [NSString stringWithFormat:format, identifier];
  return [NSURLRequest requestWithURL:[NSURL URLWithString:base]];
}

- (void)parseData:(NSData *)data
{
  NSError *error;
  NSDictionary *JSONResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
  assert(!error);
  
  _response = [[OBAResponse alloc] initWithDictionary:JSONResponse];
  
  // populate results into global store
  [[PTStore sharedStore] populateWithOBAResponse:_response];
}

- (NSArray *)obaStopGroups
{
  OBAStopGrouping *stopGrouping = _response.Data.StopGroupings.firstObject;
  OBAStopGroup *stopGroupA = stopGrouping.StopGroups.firstObject;
  OBAStopGroup *stopGroupB = stopGrouping.StopGroups.lastObject;
  NSArray *ptStopGroups = @[[PTStopGroup stopGroupFromOBACounterPart:stopGroupA],
                            [PTStopGroup stopGroupFromOBACounterPart:stopGroupB]];
  return ptStopGroups;
}

@end
