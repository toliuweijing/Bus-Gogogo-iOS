//
//  PTAllRoutesDownloadRequester.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 6/8/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTAllRoutesDownloadRequester.h"
#import "PTRoute.h"

@implementation PTAllRoutesDownloadRequester

- (NSURLRequest *)request
{
  return [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://bustime.mta.info/api/where/routes-for-agency/MTA%20NYCT.json?key=cfb3c75b-5a43-4e66-b7f8-14e666b0c1c1"]];
}

- (id)parseData:(NSData *)data
{
  return [self _routesFromData:data];
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
