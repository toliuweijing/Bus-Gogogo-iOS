//
//  PTMainViewController.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 5/17/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTMainScreenViewController.h"
#import "PTObjectPickerView.h"
#import "PTMainScreenView.h"
#import "PTMapContainerView.h"
#import "PTRouteStore.h"
#import "PTStopGroup.h"
#import "PTMonitoredVehicleJourney.h"
#import "PTRoute.h"
#import "PTStore.h"
#import "PTRoutePickerController.h"
#import "PTStopGroupPickerController.h"
#import "PTRoutePresenterController.h"

@interface PTMainScreenViewController () <
  PTRoutePickerControllerDelegate,
  PTStopGroupPickerControllerDelegate
>
{
  PTRoutePickerController *_routePickerController;
  PTStopGroupPickerController *_stopGroupPickerController;
  PTRoutePresenterController *_routePresenterController;
  
  NSArray *_vehicleJourneys;
  PTMainScreenView *_view;
}

@end

@implementation PTMainScreenViewController

- (instancetype)init
{
  if (self = [super init]) {
    _routePickerController = [[PTRoutePickerController alloc] init];
    _routePickerController.owner = self;
    _routePickerController.delegate = self;
    
    _stopGroupPickerController = [[PTStopGroupPickerController alloc] init];
    _stopGroupPickerController.owner = self;
    _stopGroupPickerController.delegate = self;
    
    _routePresenterController = [[PTRoutePresenterController alloc] init];
    
    self.navigationItem.title = @"Bus gogogo";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(_presenterButtonDidReceiveTap)];
  }
  return self;
}

- (void)loadView
{
  _view = [[PTMainScreenView alloc] initWithFrame:CGRectZero
                                  routePickerView:[_routePickerController view]
                              stopGroupPickerView:[_stopGroupPickerController view]
                                 mapContainerView:[_routePresenterController view]];
  self.view = _view;
}

- (void)viewWillLayoutSubviews
{
  [super viewWillLayoutSubviews];
  _view.topInset = self.topLayoutGuide.length;
}

#pragma mark - PTStopGroupPickerControllerDelegate

- (void)stopGroupPickerController:(PTStopGroupPickerController *)controller didFinishWithStopGroup:(PTStopGroup *)stopGroup
{
  [_routePresenterController setStopGroup:stopGroup];
}

#pragma mark - PTRoutePickerControllerDelegate

- (void)routePickerController:(PTRoutePickerController *)controller
           didFinishWithRoute:(PTRoute *)route
{
  [_stopGroupPickerController setRoute:route];
  [_routePresenterController setRoute:route];
}

#pragma mark - Private

- (CGFloat)_topInset
{
  return self.topLayoutGuide.length;
}

- (void)_presenterButtonDidReceiveTap
{
  _routePresenterController.mode = _routePresenterController.mode == PTRoutePresenterViewModeMap ? PTRoutePresenterViewModeList : PTRoutePresenterViewModeMap;
}

@end
