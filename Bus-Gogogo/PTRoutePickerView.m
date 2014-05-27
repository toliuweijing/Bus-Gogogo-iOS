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
    [self addSubview:_regionPickerView];
    
    _linePickerView = [[PTObjectPickerView alloc] init];
    _linePickerView.title = @"Line";
    [self addSubview:_linePickerView];
    
    _directionPickerView = [[PTObjectPickerView alloc] init];
    _directionPickerView.title = @"Direction";
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

@end
