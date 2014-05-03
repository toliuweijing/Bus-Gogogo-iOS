//
//  PTStopGroupPickerView.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 5/3/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTStopGroupPickerView.h"
#import "PTStopGroupPickerViewDataSource.h"

@interface PTStopGroupPickerView () <UIPickerViewDelegate, UIPickerViewDataSource>
{
  UIPickerView *_pickerView;
}

@property (nonatomic, strong) id<PTStopGroupPickerViewDataSource> dataSource;

@end

@implementation PTStopGroupPickerView

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    [self addSubview:_pickerView];
    
    _dataSource = [[PTStopGroupPickerViewDataSource alloc] init];
  }
  return self;
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  _pickerView.frame = self.bounds;
}

#pragma mark - UIPickerView

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
  return [self.dataSource numberOfComponentsInPickerView:self];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
  return [self.dataSource pickerView:self numberOfRowsInComponent:component];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
  return [self.dataSource pickerView:self titleForRow:row forComponent:component];
}

@end
