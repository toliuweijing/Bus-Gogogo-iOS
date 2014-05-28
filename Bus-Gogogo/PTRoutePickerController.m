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

@interface PTRoutePickerController () <PTRoutePickerViewDelegate, PTObjectPickerTableViewController>

@end

@implementation PTRoutePickerController
{
  PTRoutePickerView *_view;
  NSArray *_routes;
  PTRoutePickerViewComponentType _lastComponent;
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
  }];
}

#pragma mark - PTRoutePickerViewDelegate

- (void)routePickerView:(PTRoutePickerView *)view
receivedTapOnComponenet:(PTRoutePickerViewComponentType)component
{
  PTObjectPickerTableViewController *vc = [[PTObjectPickerTableViewController alloc] initWithContent:@[@"1",@"2"]];
  vc.delegate = self;
  _lastComponent = component;
  [self.owner.navigationController pushViewController:vc animated:YES];
}

#pragma mark - PTObjectPickerTableViewController

- (void)objectPickerTableViewController:(PTObjectPickerTableViewController *)controller
                   didFinishWithContent:(NSString *)content
{
  PTObjectPickerView *picker = [_view objectPickerView:_lastComponent];
  [picker setSelectionLabelText:content];
  [self.owner.navigationController popViewControllerAnimated:YES];
}
@end
