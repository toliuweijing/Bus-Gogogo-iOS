//
//  PTRoutePickerController.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 5/27/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

@class PTRoutePickerView;
@class PTRoutePickerController;
@class PTStopGroup;
@class PTRoute;

@protocol PTRoutePickerControllerDelegate <NSObject>

- (void)routePickerController:(PTRoutePickerController *)controller
           didFinishWithRoute:(PTRoute *)route;

@end

/**
 A meditary controller that governs PTRoutePickerView
 */
@interface PTRoutePickerController : NSObject

@property (nonatomic, weak) id<PTRoutePickerControllerDelegate> delegate;

@property (nonatomic, weak) UIViewController *owner;

- (PTRoutePickerView *)view;

@end
