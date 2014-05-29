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
#import "PTMonitoredVehicleJourneyDownloader.h"

@interface PTMainScreenViewController () <
  PTRoutePickerControllerDelegate,
  PTStopGroupPickerControllerDelegate,
  PTMonitoredVehicleJourneyDownloaderDelegate
>
{
  PTRoutePickerController *_routePickerController;
  PTStopGroupPickerController *_stopGroupPickerController;
  PTMonitoredVehicleJourneyDownloader *_downloader;
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
    
    self.navigationItem.title = @"Bus gogogo";
  }
  return self;
}

- (void)loadView
{
  _view = [[PTMainScreenView alloc] initWithFrame:CGRectZero
                                  routePickerView:[_routePickerController view]
                              stopGroupPickerView:[_stopGroupPickerController view]];
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
  [[_view mapContainerView] setStopGroup:stopGroup];
  [[_view mapContainerView] setVehicleJourneys:_vehicleJourneys];
}

#pragma mark - PTRoutePickerControllerDelegate

- (void)routePickerController:(PTRoutePickerController *)controller
           didFinishWithRoute:(PTRoute *)route
{
  [_stopGroupPickerController setRoute:route];
  _downloader = [[PTMonitoredVehicleJourneyDownloader alloc] initWithRouteIdentifier:route.identifier delegate:self];
}

#pragma mark - PTMonitoredVehicleJourneyDownloaderDelegate

- (void)downloader:(PTMonitoredVehicleJourneyDownloader *)downloader didReceiveVehicleJourneys:(NSArray *)vehicleJourneys
{
  _vehicleJourneys = vehicleJourneys;
}

#pragma mark - Private

- (CGFloat)_topInset
{
  return self.topLayoutGuide.length;
}

@end
