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

@interface PTBus : NSObject <MKAnnotation>
@property (nonatomic, strong) CLLocation *location;
@end
@implementation PTBus

- (CLLocationCoordinate2D)coordinate
{
  return self.location.coordinate;
}

- (NSString *)title
{
  return @"bus";
}

@end

@interface PTStopDetailView ()

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
  
//  mapView.region = MKCoordinateRegionMakeWithDistance(stop.coordinate, 100.0, 100.0);
  return mapView;
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  
  self.mapView.frame = self.bounds;
  self.activityIndicatorView.center = self.center;
}

- (void)setLocations:(NSArray *)locations
{
  [locations enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    PTBus *bus = [[PTBus alloc] init];
    bus.location = obj;
    NSLog(@"%@", obj);
    [self.mapView addAnnotation:bus];
  }];
  [self setNeedsDisplay];
  NSLog(@"update");
}

@end
