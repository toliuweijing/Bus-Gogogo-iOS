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
}

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

- (id)parseData:(NSData *)data
{
  NSError *error;
  NSDictionary *JSONResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
  assert(!error);
 
  OBAResponse *obaResponse = [[OBAResponse alloc] initWithDictionary:JSONResponse];
  
  return obaResponse.Data.Stops;
}

@end
