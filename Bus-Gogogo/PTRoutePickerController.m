//
//  PTRoutePickerController.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 5/27/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTRoutePickerController.h"
#import "PTRoutePickerView.h"
#import "PTRoute.h"
#import "PTObjectPickerTableViewController.h"
#import "PTObjectPickerView.h"
#import "PTRouteStore.h"
#import "PTRouteFilter.h"

@interface PTRoutePickerController () <PTRoutePickerViewDelegate, PTObjectPickerTableViewController>

@end

@implementation PTRoutePickerController
{
  PTRoutePickerView *_view;
  NSArray *_routes;
  PTRoutePickerViewComponentType _lastComponent;
  PTRouteFilter *_routeFilter;
}

- (id)init
{
  if (self = [super init]) {
    [self _prepareRouteData];
  }
  return self;
}

- (PTRoutePickerView *)view
{
  if (!_view) {
    _view = [[PTRoutePickerView alloc] initWithFrame:CGRectZero];
    _view.delegate = self;
  }
  return _view;
}

#pragma mark - Private

- (void)_prepareRouteData
{
  [[PTRouteStore sharedStore] retrieveRoutes:^(NSArray *routes) {
    _routes = routes;
    _routeFilter = [[PTRouteFilter alloc] initWithRoutes:routes];
  }];
}

#pragma mark - PTRoutePickerViewDelegate

- (void)routePickerView:(PTRoutePickerView *)view
receivedTapOnComponenet:(PTRoutePickerViewComponentType)component
{
  NSArray *content;
  if (PTRoutePickerViewComponentTypeRegion == component) {
    content = [_routeFilter regions];
  } else if (PTRoutePickerViewComponentTypeLine == component) {
    content = [_routeFilter lines];
  } else if (PTRoutePickerViewComponentTypeDirection == component) {
    content = [_routeFilter directions];
  } else {
    assert(NO);
  }
  
  PTObjectPickerTableViewController *vc = [[PTObjectPickerTableViewController alloc] initWithContent:content];
  vc.delegate = self;
  _lastComponent = component;
  [self.owner.navigationController pushViewController:vc animated:YES];
}

#pragma mark - PTObjectPickerTableViewController

- (void)objectPickerTableViewController:(PTObjectPickerTableViewController *)controller
                   didFinishWithContent:(NSString *)content
{
  // update ObjectPickerView
  PTObjectPickerView *picker = [_view objectPickerView:_lastComponent];
  [picker setSelectionLabelText:content];
  
  // update filter
  if (PTRoutePickerViewComponentTypeRegion == _lastComponent) {
    [_routeFilter filterByRegion:content];
  } else if (PTRoutePickerViewComponentTypeLine == _lastComponent) {
    [_routeFilter filterByLine:content];
  } else if (PTRoutePickerViewComponentTypeDirection == _lastComponent) {
    [_routeFilter filterByDirection:content];
  } else {
    assert(NO);
  }
  
  // update delegate if filter has conclusion.
  if ([_routeFilter stopGroup]) {
    [self.delegate routePickerController:self
                  didFinishWithStopGroup:[_routeFilter stopGroup]];
  }
  
  // pop back to owner.
  [self.owner.navigationController popViewControllerAnimated:YES];
}

@end
