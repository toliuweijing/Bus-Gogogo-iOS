//
//  PTMainScreenView.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 5/26/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTMainScreenView.h"
#import "PTObjectPickerView.h"
#import "PTRoutePickerView.h"

@implementation PTMainScreenView
{
  UIView *_mapView;
  PTRoutePickerView *_routePickerView;
  UIView *_stopGroupPickerView;
}

- (id)initWithFrame:(CGRect)frame
{
  assert(NO);
  return self;
}

- (id)initWithFrame:(CGRect)frame
    routePickerView:(PTRoutePickerView *)routePickerView
stopGroupPickerView:(UIView *)stopGroupPickerView
   mapContainerView:(UIView *)mapContainerView;
{
  self = [super initWithFrame:frame];
  if (self) {
    _routePickerView = routePickerView;
    [self addSubview:_routePickerView];
    
    _stopGroupPickerView = stopGroupPickerView;
    [self addSubview:_stopGroupPickerView];
    
    _mapView = mapContainerView;
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
  
  _stopGroupPickerView.frame = CGRectMake(0,
                                          CGRectGetMaxY(_routePickerView.frame),
                                          CGRectGetWidth(self.bounds),
                                          30);
  
  _mapView.frame = CGRectMake(0,
                              CGRectGetMaxY(_stopGroupPickerView.frame)+1,
                              CGRectGetWidth(self.bounds),
                              CGRectGetHeight(self.bounds) - CGRectGetMaxY(_stopGroupPickerView.frame));
  
}

@end
