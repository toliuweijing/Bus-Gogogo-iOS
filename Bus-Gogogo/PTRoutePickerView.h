//
//  PTRoutePickerView.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 5/26/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PTRoutePickerView;
@class PTObjectPickerView;

// A fixed size view
extern const CGFloat kRoutePickerViewHeight;

typedef NS_ENUM(NSInteger, PTRoutePickerViewComponentType) {
  PTRoutePickerViewComponentTypeRegion = 1,
  PTRoutePickerViewComponentTypeLine,
  PTRoutePickerViewComponentTypeDirection,
};

@protocol PTRoutePickerViewDelegate <NSObject>

- (void)routePickerView:(PTRoutePickerView *)view
receivedTapOnComponenet:(PTRoutePickerViewComponentType)component;

@end

@interface PTRoutePickerView : UIView

- (PTObjectPickerView *)objectPickerView:(PTRoutePickerViewComponentType)type;

@property (nonatomic, weak) id<PTRoutePickerViewDelegate> delegate;

@end
