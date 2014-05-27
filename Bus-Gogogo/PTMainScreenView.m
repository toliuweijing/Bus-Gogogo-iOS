//
//  PTMainScreenView.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 5/26/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTMainScreenView.h"
#import "PTObjectPickerView.h"
#import "PTMapContainerView.h"
#import "PTRoutePickerView.h"

@implementation PTMainScreenView
{
  PTMapContainerView *_mapView;
  PTRoutePickerView *_routePickerView;
}

- (id)initWithFrame:(CGRect)frame
{
  assert(NO);
  return self;
}

- (id)initWithFrame:(CGRect)frame
    routePickerView:(PTRoutePickerView *)routePickerView
{
  self = [super initWithFrame:frame];
  if (self) {
    _routePickerView = routePickerView;
    [self addSubview:_routePickerView];
    
    _mapView = [[PTMapContainerView alloc] init];
    [self addSubview:_mapView];
  }
  return self;
}

- (void)layoutSubviews
{
  _routePickerView.frame = CGRectMake(0,
                                      self.topInset,
                                      CGRectGetWidth(self.bounds),
                                      kRoutePickerViewHeight);
  _mapView.frame = CGRectMake(0,
                              CGRectGetMaxY(_routePickerView.frame)+1,
                              CGRectGetWidth(self.bounds),
                              CGRectGetHeight(self.bounds) - CGRectGetMaxY(_routePickerView.frame));
  
}

@end
