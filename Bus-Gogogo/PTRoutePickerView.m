//
//  PTRoutePickerView.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 5/26/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTRoutePickerView.h"
#import "PTObjectPickerView.h"

// A fixed size view.
const CGFloat kRoutePickerViewHeight = 90.0;

@interface PTRoutePickerView () <PTObjectPickerViewDelegate>

@end

@implementation PTRoutePickerView
{
  PTObjectPickerView *_regionPickerView;
  PTObjectPickerView *_linePickerView;
  PTObjectPickerView *_directionPickerView;
}

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    _regionPickerView = [[PTObjectPickerView alloc] init];
    _regionPickerView.title = @"Region";
    _regionPickerView.delegate = self;
    [self addSubview:_regionPickerView];
    
    _linePickerView = [[PTObjectPickerView alloc] init];
    _linePickerView.title = @"Line";
    _linePickerView.delegate = self;
    [self addSubview:_linePickerView];
    
    _directionPickerView = [[PTObjectPickerView alloc] init];
    _directionPickerView.title = @"Direction";
    _directionPickerView.delegate = self;
    [self addSubview:_directionPickerView];
  }
  return self;
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  
  CGFloat pickerViewHeight = 30;
  _regionPickerView.frame = CGRectMake(0,
                                       0,
                                       CGRectGetWidth(self.bounds),
                                       pickerViewHeight);
  
  _linePickerView.frame = CGRectMake(0,
                                     CGRectGetMaxY(_regionPickerView.frame),
                                     CGRectGetWidth(self.bounds),
                                     pickerViewHeight);
  
  _directionPickerView.frame = CGRectMake(0,
                                          CGRectGetMaxY(_linePickerView.frame),
                                          CGRectGetWidth(self.bounds),
                                          pickerViewHeight);
 
}

#pragma mark - PTObjectPickerViewDelegate

- (void)pickerViewDidReceiveTap:(PTObjectPickerView *)pickerView
{
  PTRoutePickerViewComponentType component = [self componenet:pickerView];
  [self.delegate routePickerView:self receivedTapOnComponenet:component];
}

- (PTRoutePickerViewComponentType)componenet:(PTObjectPickerView *)pickerView
{
  PTRoutePickerViewComponentType component;
  if (pickerView == _regionPickerView) {
    return PTRoutePickerViewComponentTypeRegion;
  } else if (pickerView == _linePickerView) {
    return PTRoutePickerViewComponentTypeLine;
  } else {
    return PTRoutePickerViewComponentTypeDirection;
  }
  assert(NO);
  return component;
}

- (PTObjectPickerView *)objectPickerView:(PTRoutePickerViewComponentType)type
{
  if (PTRoutePickerViewComponentTypeRegion == type) return _regionPickerView;
  if (PTRoutePickerViewComponentTypeLine == type) return _linePickerView;
  if (PTRoutePickerViewComponentTypeDirection == type) return _directionPickerView;
  assert(NO);
  return nil;
}
  


@end
