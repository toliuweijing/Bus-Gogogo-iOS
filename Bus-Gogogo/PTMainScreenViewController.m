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
#import "PTStore.h"
#import "PTRoutePickerController.h"

@interface PTMainScreenViewController ()
{
  PTRoutePickerController *_routePickerController;
  PTMainScreenView *_view;
}

@end

@implementation PTMainScreenViewController

- (instancetype)init
{
  if (self = [super init]) {
    _routePickerController = [[PTRoutePickerController alloc] init];
    _routePickerController.owner = self;
    
    self.navigationItem.title = @"Bus gogogo";
  }
  return self;
}

- (void)loadView
{
  _view = [[PTMainScreenView alloc] initWithFrame:CGRectZero
                                  routePickerView:[_routePickerController view]];
  self.view = _view;
}

- (void)viewWillLayoutSubviews
{
  [super viewWillLayoutSubviews];
  _view.topInset = self.topLayoutGuide.length;
}

#pragma mark - Private

- (CGFloat)_topInset
{
  return self.topLayoutGuide.length;
}

@end
