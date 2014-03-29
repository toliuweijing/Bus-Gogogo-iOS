//
//  PTStopDetailView.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 3/22/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTStopDetailView.h"

#import <MapKit/MapKit.h>
#import "PTStop+MKAnnotation.h"
#import "PTBus.h"
#import "PTBusMapOverlay.h"

@interface PTStopDetailView () <MKMapViewDelegate>

@property (nonatomic, strong) MKMapView *mapView;

// bus
@property (nonatomic, strong) NSArray *circleViews;

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;

@property (nonatomic, strong) PTLine *line;

@property (nonatomic, strong) PTStop *stop;

@end

@implementation PTStopDetailView

- (id)initWithFrame:(CGRect)frame stop:(PTStop *)stop line:(PTLine *)line
{
  self = [super initWithFrame:frame];
  if (self) {
    _mapView = [PTStopDetailView _mapViewWithStop:stop];
    _mapView.delegate = self;
    [self addSubview:_mapView];
    
    _stop = stop;
    _line = line;
  }
  return self;
}

+ (MKMapView *)_mapViewWithStop:(PTStop *)stop
{
  MKMapView *mapView = [[MKMapView alloc] initWithFrame:CGRectZero];
  [mapView addAnnotation:stop];
  
  return mapView;
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  
  self.mapView.frame = self.bounds;
  MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.stop.coordinate, 100, 100);
  [self.mapView setRegion:region animated:YES];
  self.activityIndicatorView.center = self.center;
}

- (void)setLocations:(NSArray *)locations
{
  [locations enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    PTBus *bus = [[PTBus alloc] init];
    bus.location = obj;
    PTBusMapOverlay *overlay = [[PTBusMapOverlay alloc] initWithBus:bus];
    [self.mapView addOverlay:overlay];
  }];
  [self setNeedsDisplay];
  [self setNeedsLayout];
  NSLog(@"update");
}

#pragma mark -
#pragma mark MKMapViewDelegate

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
  assert([overlay isKindOfClass:[PTBusMapOverlay class]]);
  MKCircleRenderer *renderer = [[MKCircleRenderer alloc] initWithOverlay:((PTBusMapOverlay *)overlay).circle];
  return renderer;
}

@end
