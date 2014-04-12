//
//  PTMapContainerView.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 4/12/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTMapContainerView.h"
#import "PTStopGroup.h"
#import "PTMonitoredVehicleJourney.h"
#import "PTPolyline.h"
#import <MapKit/MapKit.h>

@interface PTMapContainerView () <MKMapViewDelegate>

@property (nonatomic, strong) MKMapView *mapView;

@property (nonatomic, strong) NSMutableArray *polylinesForStopGroup; // MKPolyline objs

@property (nonatomic, strong) NSMutableArray *circlesForVehicleJourneys; // MKCircle objs

@end

@implementation PTMapContainerView

- (id)init
{
  assert(NO);
}

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    _mapView = [[MKMapView alloc] initWithFrame:CGRectZero];
    _mapView.showsUserLocation = YES;
    _mapView.delegate = self;
    [self addSubview:_mapView];
  }
  return self;
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  
  self.mapView.frame = self.bounds;
}

- (void)setStopGroup:(PTStopGroup *)stopGroup
{
  _stopGroup = stopGroup;
  [self _configureMapViewWithStopGroup:stopGroup];
}

- (void)_configureMapViewWithStopGroup:(PTStopGroup *)stopGroup
{
  // remove current polylines from map.
  [self.mapView removeOverlays:self.polylinesForStopGroup];
  
  // add polylines from stopGroup to map.
  self.polylinesForStopGroup = [[NSMutableArray alloc] initWithCapacity:stopGroup.polylines.count];
  [stopGroup.polylines enumerateObjectsUsingBlock:^(PTPolyline *polyline, NSUInteger idx, BOOL *stop) {
    MKPolyline *mkPolyline = polyline.mapPolyline;
    [self.polylinesForStopGroup addObject:mkPolyline];
    [self.mapView addOverlay:mkPolyline];
  }];
  
  // zoom region to fit stopGroup.
  self.mapView.region = [self.stopGroup coordinateRegion];
}

- (void)setVehicleJourneys:(NSArray *)vehicleJourneys
{
  _vehicleJourneys = vehicleJourneys;
  [self _configureMapViewWithVehicleJourneys:vehicleJourneys];
}

- (void)_configureMapViewWithVehicleJourneys:(NSArray *)vehicleJourneys
{
  [self.mapView removeOverlays:self.circlesForVehicleJourneys];
  
  self.circlesForVehicleJourneys = [[NSMutableArray alloc] init];
  for (PTMonitoredVehicleJourney *journey in vehicleJourneys) {
    // only show journeys of the same direction.
    if (journey.direction == self.stopGroup.direction) {
      MKCircle *circle = [MKCircle circleWithCenterCoordinate:journey.coordinate radius:10];
      [self.circlesForVehicleJourneys addObject:circle];
    }
  }
  [self.mapView addOverlays:self.circlesForVehicleJourneys];
}

#pragma mark - MKMapViewDelegate

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
  if ([overlay isKindOfClass:[MKCircle class]]) {
    MKCircleRenderer *renderer = [[MKCircleRenderer alloc] initWithOverlay:overlay];
    renderer.fillColor = [UIColor grayColor];
    renderer.strokeColor = [UIColor blueColor];
    renderer.lineWidth = 5.0;
    return renderer;
  } else if ([overlay isKindOfClass:[MKPolyline class]]) {
    MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    renderer.strokeColor = [UIColor redColor];
    renderer.lineWidth = 3.0;
    return renderer;
  }
  assert(false);
}

@end
