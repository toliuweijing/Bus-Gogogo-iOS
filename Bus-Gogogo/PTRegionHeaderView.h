//
//  PTRegionHeaderView.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 6/7/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PTRegionHeaderView;

@protocol PTRegionHeaderViewDelegate

- (void)view:(PTRegionHeaderView *)view
selectedRegion:(NSString *)region;

@end

@interface PTRegionHeaderView : UIView

@property (nonatomic, weak)
id<PTRegionHeaderViewDelegate> delegate;

+ (PTRegionHeaderView *)loadNibWithOwner:(id)owner;

@end
