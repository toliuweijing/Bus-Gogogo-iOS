//
//  PTStop+MKAnnotation.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 3/22/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTStop+MKAnnotation.h"

@implementation PTStop (MKAnnotation)

- (NSString *)title
{
  return self.identifier;
}

- (CLLocationCoordinate2D)coordinate
{
  return self.location.coordinate;
}

@end