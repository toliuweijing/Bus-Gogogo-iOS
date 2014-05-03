//
//  PTStopGroupPickerView.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 5/3/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PTStopGroupPickerView;

@protocol PTStopGroupPickerViewDataSource

- (NSInteger)pickerView:(PTStopGroupPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component;

- (NSInteger)numberOfComponentsInPickerView:(PTStopGroupPickerView *)pickerView;

- (NSString *)pickerView:(PTStopGroupPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component;
@end

@interface PTStopGroupPickerView : UIView

//- (instancetype)initWithFrame:(CGRect)frame dataSource:(id<PTStopGroupPickerViewDataSource>)dataSource;
@property (nonatomic, strong, readonly) id<PTStopGroupPickerViewDataSource> dataSource;

@end
