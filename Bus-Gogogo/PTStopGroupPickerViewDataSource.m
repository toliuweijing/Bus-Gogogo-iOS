//
//  PTStopGroupPickerViewDataSource.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 5/3/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTStopGroupPickerViewDataSource.h"

@implementation PTStopGroupPickerViewDataSource

#pragma mark - PTStopGroupPickerViewDataSource

- (NSInteger)pickerView:(PTStopGroupPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
  return 3;
}

- (NSInteger)numberOfComponentsInPickerView:(PTStopGroupPickerView *)pickerView
{
  return 3;
}

- (NSString *)pickerView:(PTStopGroupPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
  return [@(row) stringValue];
}

@end
