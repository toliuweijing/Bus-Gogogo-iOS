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
#import "PTMonitoredVehicleJourneyDownloader.h"
#import "PTStopGroupDownloadRequester.h"
#import "PTRoute.h"
#import "PTStopGroup.h"

@interface PTRoutePresenterController () <PTMonitoredVehicleJourneyDownloaderDelegate>

@end

@implementation PTRoutePresenterController
{
  PTRoutePresenterView *_view;
  PTMapContainerView *_mapView;
  PTListContainerView *_listView;
  PTRoute *_route;
  PTStopGroup *_stopGroup;
  NSArray *_vehcileJourneys;
  PTMonitoredVehicleJourneyDownloader *_downloader;
  PTDownloadTask *_stopGroupTask;
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
  [_listView setRoute:route];
  [self _updateVehicleJourneysPeriodic:YES];
}

- (void)setRoute:(PTRoute *)route direction:(int)direction
{
  [self setRoute:route];
  
  _stopGroupTask =
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

#pragma mark - PTMonitoredVehicleJourneyDownloaderDelegate

- (void)downloader:(PTMonitoredVehicleJourneyDownloader *)downloader didReceiveVehicleJourneys:(NSArray *)vehicleJourneys
{
  [self _setVehicleJourneys:vehicleJourneys];
}

#pragma mark - Private

- (void)_updateVehicleJourneys:(NSTimer *)timer
{
  _downloader = [[PTMonitoredVehicleJourneyDownloader alloc] initWithRouteIdentifier:_route.identifier delegate:self];
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
