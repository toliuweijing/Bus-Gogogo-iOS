//
//  PTRoute.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 4/5/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTStopGroup.h"
#import "OBADataModel.h"
#import "PTBase.h"

@implementation PTStopGroup

+ (PTStopGroup *)stopGroupFromOBACounterPart:(OBAStopGroup *)oba
{
  PTStopGroup *stopGroup = [[PTStopGroup alloc] init];
  stopGroup.name = oba.Name.Name;
  stopGroup.stopIDs = oba.StopIds;
  // hack
  if ([oba.Id intValue] == 1) {
    NSArray *polylinPoints = decodePolyLine(oba.Polylines.lastObject);
    polylinPoints = [polylinPoints arrayByAddingObjectsFromArray:decodePolyLine(oba.Polylines.firstObject)];
    stopGroup.polylinePoints = polylinPoints;
  } else {
    stopGroup.polylinePoints = decodePolyLines(oba.Polylines);
  }
  stopGroup.direction = [oba.Id intValue];
  return stopGroup;
}

- (MKCoordinateRegion)coordinateRegion
{
//  assert(self.polylinePoints.count > 0);
  CLLocation *initial = self.polylinePoints.firstObject;
  CLLocationDegrees leftMost = initial.coordinate.longitude;
  CLLocationDegrees rightMost = initial.coordinate.longitude;
  CLLocationDegrees topMost = initial.coordinate.latitude;
  CLLocationDegrees bottomMost = initial.coordinate.latitude;
  
  for (CLLocation *location in self.polylinePoints) {
    CLLocationDegrees lon = location.coordinate.longitude;
    CLLocationDegrees lat = location.coordinate.latitude;
    leftMost = MIN(leftMost, lon);
    rightMost = MAX(rightMost, lon);
    topMost = MIN(topMost, lat);
    bottomMost = MAX(bottomMost, lat);
  }
  
  CLLocationCoordinate2D center = CLLocationCoordinate2DMake((topMost + bottomMost) / 2, (leftMost + rightMost) / 2);
  MKCoordinateSpan span = MKCoordinateSpanMake(bottomMost - topMost, rightMost - leftMost);
  
  MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
  return region;
}

@end
