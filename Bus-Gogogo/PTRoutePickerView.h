//
//  PTRoutePickerView.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 5/26/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

// A fixed size view
extern const CGFloat kRoutePickerViewHeight;

// Each PTRoute should contain three components, which are used
// to filter in PTRoutePickerView.
@protocol PTRouteComponents <NSObject>

- (NSString *)region;
- (NSString *)line;
- (NSArray *)directions;

@end

@interface PTRoutePickerView : UIView

/**
 A list of id<PTRouteComponents> objects.
 */
@property (nonatomic, strong) NSArray *routes;

@end
