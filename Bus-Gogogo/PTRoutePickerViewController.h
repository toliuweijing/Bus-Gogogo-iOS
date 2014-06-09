//
//  PTRoutePickerViewController.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 6/7/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PTRoutePickerViewController;
@class PTRoute;

@protocol PTRoutePickerViewControllerDelegate

- (void)controller:(PTRoutePickerViewController *)controller
didFinishWithRoute:(PTRoute *)route;

@end

@interface PTRoutePickerViewController : UIViewController

@property (nonatomic, weak)
id <PTRoutePickerViewControllerDelegate> delegate;

@end
