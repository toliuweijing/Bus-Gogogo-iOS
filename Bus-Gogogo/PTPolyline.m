//
//  PTPolyline.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 4/12/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTPolyline.h"
#import "OBADataModel.h"
#import "PTBase.h"

@interface PTPolyline ()

@property (nonatomic, strong) OBAPolyline *oba;

@end

@implementation PTPolyline

- (instancetype)initWithOBACounterPart:(OBAPolyline *)oba
{
  if (self = [super init]) {
    _oba = oba;
  }
  return self;
}

- (MKPolyline *)mapPolyline
{
  NSArray *points = [PTBase decodePolyLine:self.oba];
  
  NSUInteger count = points.count;
  CLLocationCoordinate2D coordinates[count];
  for (int i = 0 ; i < count ; ++i) {
    coordinates[i] = [[points objectAtIndex:i] coordinate];
  }
  MKPolyline *mkpolyline = [MKPolyline polylineWithCoordinates:coordinates count:count];
  
  return mkpolyline;
}

@end
