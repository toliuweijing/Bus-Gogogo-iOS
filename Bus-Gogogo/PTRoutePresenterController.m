//
//  PTRoutePresenterController.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 5/30/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTRoutePresenterController.h"
#import "PTMapContainerView.h"
#import "PTListContainerView.h"
#import "PTRoutePresenterView.h"
#import "PTStopGroupDownloadRequester.h"
#import "PTMonitoredVehicleJourneyDownloadRequester.h"
#import "PTRoute.h"
#import "PTStopGroup.h"

@interface PTRoutePresenterController ()

@end

@implementation PTRoutePresenterController
{
  PTRoutePresenterView *_view;
  PTMapContainerView *_mapView;
  PTListContainerView *_listView;
  PTRoute *_route;
  PTStopGroup *_stopGroup;
  NSArray *_vehcileJourneys;
  NSTimer *_timer;
}

- (id)init
{
  if (self = [super init]) {
    _mapView = [[PTMapContainerView alloc] initWithFrame:CGRectZero];
    _listView = [[PTListContainerView alloc] initWithFrame:CGRectZero];
    
    _view = [[PTRoutePresenterView alloc] initWithFrame:CGRectZero];
//    [_view setContentView:_listView];
    [_view setContentView:_mapView];
    
    _mode = PTRoutePresenterViewModeMap;
  }
  return self;
}

- (UIView *)view
{
  return _view;
}

- (void)setMode:(PTRoutePresenterViewMode)mode
{
  _mode = mode;
  if (PTRoutePresenterViewModeMap == mode) {
    [_view setContentView:_mapView];
  } else {
    [_view setContentView:_listView];
  }
}

- (void)setStopGroup:(PTStopGroup *)stopGroup
{
  _stopGroup = stopGroup;
  [self _updateSubviews];
}

- (void)_setVehicleJourneys:(NSArray *)vehicleJourneys
{
  _vehcileJourneys = vehicleJourneys;
  [self _updateSubviews];
}

- (void)setRoute:(PTRoute *)route
{
  _route = route;
  [self _updateVehicleJourneysPeriodic:YES];
}

- (void)setRoute:(PTRoute *)route direction:(int)direction
{
  [self setRoute:route];
  
  [PTDownloadTask
   scheduledTaskWithRequester:[[PTStopGroupDownloadRequester alloc] initWithRouteId:route.identifier]
   callback:^(NSArray *stopGroups, NSError *error) {
     if (error == nil) {
       for (PTStopGroup *s in stopGroups) {
         if (s.direction == direction) {
           [self setStopGroup:s];
           break;
         }
       }
     }
   }];
}

#pragma mark - Private

- (void)_updateVehicleJourneys:(NSTimer *)timer
{
  [PTDownloadTask
   scheduledTaskWithRequester:[[PTMonitoredVehicleJourneyDownloadRequester alloc] initWithRouteId:_route.identifier]
   callback:^(NSArray *journeys, NSError *error) {
     if (error == nil) {
       [self _setVehicleJourneys:journeys];
     }
   }];
}

- (void)_updateVehicleJourneysPeriodic:(BOOL)periodic
{
  [_timer invalidate];
  
  [self _updateVehicleJourneys:nil];
  if (periodic) {
    _timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(_updateVehicleJourneys:) userInfo:nil repeats:YES];
  }
}

- (void)_updateSubviews
{
  if (_mapView.stopGroup != _stopGroup) {
    _mapView.stopGroup = _stopGroup;
  }
  if (_mapView.vehicleJourneys != _vehcileJourneys) {
    _mapView.vehicleJourneys = _vehcileJourneys;
  }
  [_listView setStopGroup:_stopGroup vehicleJourneys:_vehcileJourneys];
}

@end
