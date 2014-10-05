//
//  PTStop.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 3/22/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTStop.h"
#import <CoreLocation/CoreLocation.h>
#import "PTRoute.h"

@interface PTStop ()

@property (nonatomic, copy, readwrite) NSString *identifier;

@property (nonatomic, strong, readwrite) CLLocation *location;

@property (nonatomic, strong) OBAStop *obaStop;

@end

@implementation PTStop

- (instancetype)initWithOBAStop:(OBAStop *)obaStop
{
  if (self = [super init]) {
    _obaStop = obaStop;
  }
  return self;
}

- (NSString *)name
{
  return self.obaStop.Name;
}

- (NSString *)identifier
{
  return self.obaStop.Id;
}

- (CLLocation *)location
{
  return [[CLLocation alloc] initWithLatitude:[self.obaStop.Lat floatValue] longitude:[self.obaStop.Lon floatValue]];
}

- (NSString *)directionText
{
  return self.obaStop.Direction;
}

- (NSArray *)routes
{
  NSMutableArray *routes = [NSMutableArray new];
  for (OBARoute *r in self.obaStop.Routes) {
    [routes addObject:[[PTRoute alloc] initWithOBACounterPart:r]];
  }
  return routes;
}

- (NSString *)code
{
  return _obaStop.Code;
}

@end
