//
//  PTRoutePickerViewController.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 6/7/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTRegionHeaderView.h"

@class PTRoutePickerViewController;
@class PTRoute;

@protocol PTRoutePickerViewControllerDelegate

- (void)routePickerViewController:(PTRoutePickerViewController *)controller
               didFinishWithRoute:(PTRoute *)route;

@end

@interface PTRoutePickerViewController : UIViewController <
  PTRegionHeaderViewDelegate,
  UITableViewDelegate,
  UITableViewDataSource
>

@property (nonatomic, weak) IBOutlet
id <PTRoutePickerViewControllerDelegate> delegate;

@end
