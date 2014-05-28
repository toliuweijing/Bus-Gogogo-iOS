//
//  PTRoutePickerController.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 5/27/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

@class PTRoutePickerView;
@class PTRoutePickerController;

/**
 A meditary controller that governs PTRoutePickerView
 */
@interface PTRoutePickerController : NSObject

@property (nonatomic, weak) UIViewController *owner;

- (PTRoutePickerView *)view;

@end
