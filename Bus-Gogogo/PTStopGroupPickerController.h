//
//  PTStopGroupPickerController.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 5/29/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PTRoute;
@class PTStopGroup;
@class PTStopGroupPickerController;

@protocol PTStopGroupPickerControllerDelegate <NSObject>

- (void)stopGroupPickerController:(PTStopGroupPickerController *)controller
           didFinishWithStopGroup:(PTStopGroup *)stopGroup;


@end

@interface PTStopGroupPickerController : NSObject

@property (nonatomic, weak) id<PTStopGroupPickerControllerDelegate> delegate;

@property (nonatomic, weak) UIViewController *owner;

- (void)setRoute:(PTRoute *)route;

- (UIView *)view;

@end
