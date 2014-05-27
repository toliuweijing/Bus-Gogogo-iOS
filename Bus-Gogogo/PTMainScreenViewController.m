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

@interface PTMainScreenViewController ()
{
  PTMainScreenView *_view;
}

@end

@implementation PTMainScreenViewController
{
}

- (instancetype)init
{
  if (self = [super init]) {
    self.navigationItem.title = @"Bus gogogo";
  }
  return self;
}

- (void)loadView
{
  _view = [[PTMainScreenView alloc] init];
  self.view = _view;
}

- (void)viewWillLayoutSubviews
{
  [super viewWillLayoutSubviews];
  _view.topInset = self.topLayoutGuide.length;
}

- (void)viewDidAppear:(BOOL)animated
{
  /**
   HACK: use -setNeedsLayout to redraw subviews, as subviews have been changed.
   i.e. new titles .
   */
  for (UIView *view in self.view.subviews) {
    [view setNeedsLayout];
  }
  [self.view setNeedsLayout];
  
  id<PTRouteStore> routeStore = [PTRouteStore sharedStore];
  [routeStore retrieveRoutes:^(NSArray *routes) {
    NSLog(@"all routes are loaded in route store");
  }];
}

#pragma mark - Private

- (CGFloat)_topInset
{
  return self.topLayoutGuide.length;
}

@end
