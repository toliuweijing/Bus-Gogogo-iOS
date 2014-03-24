//
//  PTStopDetailView.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 3/22/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PTStop;
@class PTLine;

@interface PTStopDetailView : UIView

- (id)initWithFrame:(CGRect)frame stop:(PTStop *)stop line:(PTLine *)line;

@property (nonatomic, strong) NSArray *locations;

@end
