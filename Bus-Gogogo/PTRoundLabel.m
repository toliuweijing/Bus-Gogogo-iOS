//
//  PTDesignableButton.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 9/28/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTRoundLabel.h"

@implementation PTRoundLabel

- (void)setCornerRadius:(NSInteger)cornerRadius
{
  _cornerRadius = cornerRadius;
  self.layer.masksToBounds = YES;
  self.layer.cornerRadius = cornerRadius;
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
  _borderWidth = borderWidth;
  self.layer.borderWidth = borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor
{
  _borderColor = borderColor;
  self.layer.borderColor = [borderColor CGColor];
}

@end
