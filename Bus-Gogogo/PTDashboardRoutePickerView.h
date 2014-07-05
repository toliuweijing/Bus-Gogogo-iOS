//
//  PTDashboardRoutePickerView.h
//  Bus-Gogogo
//
//  Created by Developer on 6/15/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PTRoute;

@interface PTDashboardRoutePickerView : UIView

@property (nonatomic, weak) IBOutlet UIView *linePicker;

@property (nonatomic, weak) IBOutlet UIView *directionPicker;

@property (nonatomic, weak) IBOutlet UIView *emptyRoutePicker;

- (void)setRoute:(PTRoute *)route;
- (void)flipDirection;

- (int)direction;

- (void)setLoadingIndicator:(BOOL)enable;
@end
