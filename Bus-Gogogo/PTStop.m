//
//  PTStop.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 3/22/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTStop.h"

@interface PTStop ()

@property (nonatomic, copy, readwrite) NSString *identifier;

@property (nonatomic, strong, readwrite) CLLocation *location;

@end

@implementation PTStop

+ (PTStop *)stopAtBayRidgeShoreRoad
{
  PTStop *stop = [[PTStop alloc] init];
  
  NSString *identifier = @"BAY RIDGE AV/SHORE RD";
  CLLocationDegrees latitude = 40.638553;
  CLLocationDegrees longtitude = -74.035362;
  
  stop.identifier = identifier;
  stop.location = [[CLLocation alloc] initWithLatitude:latitude longitude:longtitude];
  
  return stop;
}

@end
