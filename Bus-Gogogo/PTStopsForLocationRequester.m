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

@property (nonatomic, strong) NSArray *stops;

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
  NSMutableArray *a = [NSMutableArray new];
  for (OBAStop *s in _response.Data.Stops) {
    PTStop *ptstop = [[PTStop alloc] initWithOBAStop:s];
    [a addObject:ptstop];
  }
  _stops = a;
}

@end

