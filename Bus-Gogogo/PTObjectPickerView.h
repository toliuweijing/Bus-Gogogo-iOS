//
//  PTMainPickerView.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 5/17/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PTObjectPickerView;

@protocol PTObjectPickerViewDelegate <NSObject>

- (void)pickerViewDidReceiveTap:(PTObjectPickerView *)pickerView;

@end

@interface PTObjectPickerView : UIView

@property (nonatomic, weak) id<PTObjectPickerViewDelegate> delegate;

@property (nonatomic, strong) NSString *title;

- (void)setSelectionLabelText:(NSString *)text;

@end
