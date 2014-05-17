//
//  PTMainPickerView.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 5/17/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PTMainPickerView;

@protocol PTMainPickerViewDelegate <NSObject>

- (void)pickerViewDidReceiveTap:(PTMainPickerView *)pickerView;

@end

@interface PTMainPickerView : UIView

@property (nonatomic, weak) id<PTMainPickerViewDelegate> delegate;

@property (nonatomic, strong) NSString *title;

@end
