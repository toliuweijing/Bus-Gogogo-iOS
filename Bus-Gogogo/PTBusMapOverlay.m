//
//  PTBusMapOverlay.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 3/29/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTBusMapOverlay.h"
#import "PTBus.h"

@interface PTBusMapOverlay ()

@property (nonatomic, strong) PTBus *bus;

@end

@implementation PTBusMapOverlay

#pragma mark -
#pragma mark MKOverlay

- (instancetype)initWithBus:(PTBus *)bus
{
  if (self = [super init]) {
    _bus = bus;
    _circle = [MKCircle circleWithCenterCoordinate:bus.location.coordinate radius:5.0];
  }
  return self;
}

- (CLLocationCoordinate2D)coordinate
{
  return self.bus.location.coordinate;
}

// boundingMapRect should be the smallest rectangle that completely contains the overlay.
// For overlays that span the 180th meridian, boundingMapRect should have either a negative MinX or a MaxX that is greater than MKMapSizeWorld.width.
- (MKMapRect)boundingMapRect
{
  return self.circle.boundingMapRect;
}

//// Implement intersectsMapRect to provide more precise control over when the view for the overlay should be shown.
//// If omitted, MKMapRectIntersectsRect([overlay boundingRect], mapRect) will be used instead.
//- (BOOL)intersectsMapRect:(MKMapRect)mapRect
//{
//  
//}

//// If this method is implemented and returns YES, MKMapView may use it as a hint to skip loading or drawing the built in map content in the area covered by this overlay.
//- (BOOL)canReplaceMapContent NS_AVAILABLE(10_9, 7_0)
//{
//  
//}

#pragma mark -
#pragma mark Setters/Getters

- (void)setBus:(PTBus *)bus
{
  _bus = bus;
  self.circle = [MKCircle circleWithCenterCoordinate:bus.location.coordinate radius:5.0];
}

@end
