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

- (void)regionHeaderView:(PTRegionHeaderView *)view
      selectionDidChange:(NSString *)selection;

@end

@interface PTRegionHeaderView : UIView

@property (nonatomic, weak)
id<PTRegionHeaderViewDelegate> delegate;

- (NSString *)selectedRegion;

+ (PTRegionHeaderView *)loadNibWithOwner:(id)owner;

@end
