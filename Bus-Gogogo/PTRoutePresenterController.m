//
//  PTRoutePresenterController.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 5/30/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTRoutePresenterController.h"
#import "PTMapContainerView.h"
#import "PTRoutePresenterView.h"

@implementation PTRoutePresenterController
{
  PTRoutePresenterView *_view;
  PTMapContainerView *_mapView;
}

- (id)init
{
  if (self = [super init]) {
    _mapView = [[PTMapContainerView alloc] initWithFrame:CGRectZero];
    
    _view = [[PTRoutePresenterView alloc] initWithFrame:CGRectZero];
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
    assert(NO);
  }
}

- (void)setStopGroup:(PTStopGroup *)stopGroup
{
  assert(_mode == PTRoutePresenterViewModeMap);
  _mapView.stopGroup = stopGroup;
}

- (void)setVehicleJourneys:(NSArray *)vehicleJourneys
{
  assert(_mode == PTRoutePresenterViewModeMap);
  _mapView.vehicleJourneys = vehicleJourneys;
}

@end
