//
//  PTDesignableButton.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 9/28/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface PTRoundLabel : UILabel

@property (nonatomic, assign) IBInspectable NSInteger cornerRadius;
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
@property (nonatomic, assign) IBInspectable UIColor *borderColor;

@end
