//
//  PTMainViewController.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 5/17/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTMainScreenViewController.h"
#import "PTMainPickerView.h"
#import "PTMapContainerView.h"
#import "PTRouteStore.h"
#import "PTStore.h"

@interface PTMainScreenViewController ()

@end

@implementation PTMainScreenViewController
{
  PTMainPickerView *_regionPickerView;
  PTMainPickerView *_linePickerView;
  PTMainPickerView *_directionPickerView;
  PTMapContainerView *_mapView;
}

- (instancetype)init
{
  if (self = [super init]) {
    self.navigationItem.title = @"Bus gogogo";
  }
  return self;
}

/**
 Load all subviews
 */
- (void)viewDidLoad
{
  [super viewDidLoad];
  
  _mapView = [[PTMapContainerView alloc] init];
  [self.view addSubview:_mapView];
  
  _regionPickerView = [[PTMainPickerView alloc] init];
  [self.view addSubview:_regionPickerView];
  
  _linePickerView = [[PTMainPickerView alloc] init];
  [self.view addSubview:_linePickerView];
  
  _directionPickerView = [[PTMainPickerView alloc] init];
  [self.view addSubview:_directionPickerView];
}

/**
 Layout all subviews
 */
- (void)viewDidLayoutSubviews
{
  [super viewDidLayoutSubviews];
  
  CGFloat pickerViewHeight = 30;
  _regionPickerView.frame = CGRectMake(0,
                                       [self _topInset],
                                       CGRectGetWidth(self.view.bounds),
                                       pickerViewHeight);
  _regionPickerView.title = @"Region";
  
  _linePickerView.frame = CGRectMake(0,
                                     CGRectGetMaxY(_regionPickerView.frame),
                                     CGRectGetWidth(self.view.bounds),
                                     pickerViewHeight);
  _linePickerView.title = @"Line";
  
  _directionPickerView.frame = CGRectMake(0,
                                          CGRectGetMaxY(_linePickerView.frame),
                                          CGRectGetWidth(self.view.bounds),
                                          pickerViewHeight);
  _directionPickerView.title = @"Direction";
  
  _mapView.frame = CGRectMake(0,
                              CGRectGetMaxY(_directionPickerView.frame),
                              CGRectGetWidth(self.view.bounds),
                              CGRectGetHeight(self.view.bounds) - CGRectGetMaxY(_directionPickerView.frame));
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
