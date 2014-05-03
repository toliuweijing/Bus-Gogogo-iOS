//
//  PTDashBoardView.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 5/3/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTDashBoardView.h"
#import "PTMapContainerView.h"
#import "PTStopGroupPickerView.h"

typedef NS_ENUM(NSInteger, PTDashBoardSubviewType) {
  PTDashBoardSubviewTypeMap = 1,
  PTDashBoardSubviewTypeStopGroupPicker,
};

@interface PTDashBoardView ()
{
  PTMapContainerView *_mapContainerView;
  PTStopGroupPickerView *_stopGroupPickerView;
}

@end

@implementation PTDashBoardView

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    _mapContainerView = [[PTMapContainerView alloc] initWithFrame:CGRectZero];
    [self addSubview:_mapContainerView];
    
    _stopGroupPickerView = [[PTStopGroupPickerView alloc] initWithFrame:CGRectZero];
    [self addSubview:_stopGroupPickerView];
  }
  return self;
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  
  [self _layoutMapContainerView];
  [self _layoutStopGroupPickerView];
}

- (void)_layoutStopGroupPickerView
{
  _stopGroupPickerView.frame = [self _rectForSubview:PTDashBoardSubviewTypeStopGroupPicker];
}

- (CGRect)_rectForSubview:(PTDashBoardSubviewType)subviewType
{
//  static const CGFloat kMapViewHeight = 200;
  static const CGFloat kPickerViewHeight = 216;
  
  CGFloat x = CGRectGetMinX(self.bounds);
  CGFloat y = CGRectGetMinY(self.bounds);
  CGFloat w = CGRectGetWidth(self.bounds);
  CGFloat h = CGRectGetHeight(self.bounds);
  
  CGFloat mapViewHeight = h - kPickerViewHeight;
  CGFloat pickerViewHeight = kPickerViewHeight;
  
  switch (subviewType) {
    case PTDashBoardSubviewTypeMap:
      return CGRectMake(x, y+h-mapViewHeight, w, mapViewHeight);
    case PTDashBoardSubviewTypeStopGroupPicker:
      return CGRectMake(x, y, w, pickerViewHeight);
    default:
      break;
  }
  assert(NO);
}

- (void)_layoutMapContainerView
{
  _mapContainerView.frame = [self _rectForSubview:PTDashBoardSubviewTypeMap];
}

@end
