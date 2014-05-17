//
//  PTMainViewController.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 5/17/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTMainScreenViewController.h"
#import "PTMainPickerView.h"

@interface PTMainScreenViewController ()

@end

@implementation PTMainScreenViewController
{
  PTMainPickerView *_regionPickerView;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  _regionPickerView = [[PTMainPickerView alloc] init];
  [self.view addSubview:_regionPickerView];
}

- (CGFloat)_topInset
{
  return self.topLayoutGuide.length;
}

- (void)viewDidLayoutSubviews
{
  [super viewDidLayoutSubviews];
  
  CGFloat regionPickerViewHeight = 40;
  _regionPickerView.frame = CGRectMake(0,
                                       [self _topInset],
                                       CGRectGetWidth(self.view.bounds),
                                       regionPickerViewHeight);
  NSLog(@"%lf, %lf, %lf", self.view.bounds.size.width, self.view.bounds.size.height, [self _topInset]);
}

- (void)viewDidAppear:(BOOL)animated
{
  _regionPickerView.title = @"Region";
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
