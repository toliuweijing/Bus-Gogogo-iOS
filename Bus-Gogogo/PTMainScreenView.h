//
//  PTMainScreenView.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 5/26/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PTRoutePickerView;

@interface PTMainScreenView : UIView

@property (nonatomic, assign) CGFloat topInset;

- (id)initWithFrame:(CGRect)frame
    routePickerView:(PTRoutePickerView *)routePickerView;

@end
