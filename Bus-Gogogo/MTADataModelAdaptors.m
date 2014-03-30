//
//  MTADataModelAdaptors.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 3/29/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "MTADataModelAdaptors.h"

@implementation MTAVehicleLocation (Adaptor)

- (CLLocationCoordinate2D)coordinate
{
  return CLLocationCoordinate2DMake(self.Latitude.doubleValue, self.Longitude.doubleValue);
}

@end
