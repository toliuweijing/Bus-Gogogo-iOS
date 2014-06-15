//
//  PTRouteFilter.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 5/28/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTRouteFilter.h"
#import "PTRoute.h"

@implementation PTRouteFilter
{
  NSArray *_routes;
  NSString *_regionFilter;
  NSString *_lineFilter;
}

- (id)init
{
  assert(NO);
}

- (id)initWithRoutes:(NSArray *)routes
{
  if (self = [super init]) {
    _routes = routes;
  }
  return self;
}

- (NSArray *)regions
{
  NSMutableSet *regions = [NSMutableSet new];
  for (PTRoute *route in _routes) {
    [regions addObject:[route regionPrefix]];
  }
  return [[regions allObjects] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}

- (NSArray *)lines
{
  // Return lines in the specified region(_regionFilter).
  NSMutableSet *lines = [NSMutableSet new];
  for (PTRoute *route in _routes) {
    if ([route.regionPrefix isEqualToString:_regionFilter]) {
      [lines addObject:[route number]];
    }
  }
  
  // sort
  NSArray *ret = [lines allObjects];
  NSArray *sortedRet = [ret sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
    return [obj1 intValue] > [obj2 intValue];
  }];
  return sortedRet;
}

- (PTRoute *)route
{
  return [self routeWithRegion:_regionFilter line:_lineFilter];
}

- (PTRoute *)routeWithRegion:(NSString *)region line:(NSString *)line
{
  for (PTRoute *route in _routes) {
    if ([route.regionPrefix isEqualToString:region] &&
        [route.number isEqualToString:line]) {
      return route;
    }
  }
  return nil;
}

- (void)filterByRegion:(NSString *)region
{
  _regionFilter = region;
}

- (void)filterByLine:(NSString *)line
{
  _lineFilter = line;
}

#pragma mark - Private

@end
