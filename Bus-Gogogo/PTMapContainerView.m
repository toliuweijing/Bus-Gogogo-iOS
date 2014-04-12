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

static NSString *const kMapViewReuseIdentifierVehcileJourneys = @"vehcile_journeys_annotation";

@interface PTMapContainerView () <MKMapViewDelegate>

@property (nonatomic, strong) MKMapView *mapView;

@property (nonatomic, strong) CLLocation *userLocation;

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
    _mapView.userTrackingMode = MKUserTrackingModeFollow;
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
//  self.mapView.region = [self.stopGroup coordinateRegion];
}

- (void)setVehicleJourneys:(NSArray *)vehicleJourneys
{
  [self _configureMapViewWithVehicleJourneys:vehicleJourneys];
  _vehicleJourneys = vehicleJourneys;
//  [self _configureMapViewWithVehicleJourneys:vehicleJourneys];
}

- (void)_configureMapViewWithVehicleJourneys:(NSArray *)vehicleJourneys
{
  assert(self.vehicleJourneys != vehicleJourneys);
  
#if 0 // 1 to enable overlays
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
  
#else // 0 to enable annotation
  [self.mapView removeAnnotations:self.vehicleJourneys];
  [self.mapView addAnnotations:vehicleJourneys];
  
#endif
}

- (void)setUserLocation:(CLLocation *)userLocation
{
  _userLocation = userLocation;
  [self _configureMapViewWithUserLocation:userLocation];
}

- (void)_configureMapViewWithUserLocation:(CLLocation *)userLocation
{
  MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 1000, 1000);
  self.mapView.region = region;
}

#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
  if ([annotation isKindOfClass:[PTMonitoredVehicleJourney class]]) {
    
    MKAnnotationView *view  = [self.mapView dequeueReusableAnnotationViewWithIdentifier:kMapViewReuseIdentifierVehcileJourneys];
    view = view?: [[MKAnnotationView alloc] initWithAnnotation:annotation
                                               reuseIdentifier:kMapViewReuseIdentifierVehcileJourneys];
    view.image = [UIImage imageNamed:@"bus"];
    view.frame = CGRectMake(view.frame.origin.x,
                            view.frame.origin.y,
                            CGRectGetWidth(view.frame),
                            CGRectGetHeight(view.frame));
    return view;
  } else {
    return nil;
  }
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
  self.userLocation = userLocation.location;
}

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
