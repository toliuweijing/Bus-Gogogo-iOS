//
//  PTRoutesForLocationRequester.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 9/28/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTStopsForLocationRequester.h"
#import "OBADataModel.h"

@interface PTStopsForLocationRequester ()
{
  CLLocation *_location;
  OBAResponse *_response;
}

@property (nonatomic, strong) NSArray *routeStopPairs;

@end

@implementation PTStopsForLocationRequester

- (instancetype)initWithLocation:(CLLocation *)location
{
  if (self = [super init]) {
    _location = location;
  }
  return self;
}

- (NSURLRequest *)request
{
  NSString *format = @"http://api.prod.obanyc.com/api/where/stops-for-location.json?key=TEST&lat=%lf&lon=%lf";
  NSString *urlText = [NSString stringWithFormat:format, _location.coordinate.latitude, _location.coordinate.longitude];
  return [NSURLRequest requestWithURL:[NSURL URLWithString:urlText]];
}

- (void)parseData:(NSData *)data
{
  NSError *error;
  NSDictionary *JSONResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
  assert(!error);
 
  _response = [[OBAResponse alloc] initWithDictionary:JSONResponse];
}

- (NSArray *)obaRoutes
{
  return _response.Data.Stops;
}

- (NSArray *)routeStopPairs
{
  if (_routeStopPairs) {
    return _routeStopPairs;
  }
  
  if (!_response) {
    return nil;
  }
  
  NSMutableArray *pairs = [NSMutableArray new];
  for (OBAStop *stop in _response.Data.Stops) {
    for (OBARoute *route in stop.Routes) {
      RouteStopPair *p = [RouteStopPair new];
      p.route = [[PTRoute alloc] initWithOBACounterPart:route];
      p.stop = [[PTStop alloc] initWithOBAStop:stop];
      [pairs addObject:p];
    }
  }
  _routeStopPairs = pairs;
  return _routeStopPairs;
}

- (NSArray *)stopIds
{
  return [_response valueForKeyPath:@"Data.Stops.Id"];
}

@end

@implementation RouteStopPair
@end
