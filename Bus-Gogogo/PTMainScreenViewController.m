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

@interface PTMainScreenViewController ()

@end

@implementation PTMainScreenViewController
{
  PTMainPickerView *_regionPickerView;
  PTMainPickerView *_linePickerView;
  PTMainPickerView *_directionPickerView;
  PTMapContainerView *_mapView;
}

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

- (CGFloat)_topInset
{
  return self.topLayoutGuide.length;
}

- (void)viewDidLayoutSubviews
{
  [super viewDidLayoutSubviews];
  
  CGFloat pickerViewHeight = 40;
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
  for (UIView *view in self.view.subviews) {
    [view setNeedsLayout];
  }
  [self.view setNeedsLayout];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
