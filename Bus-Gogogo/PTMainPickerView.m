//
//  PTMainPickerView.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 5/17/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTMainPickerView.h"

@implementation PTMainPickerView
{
  UIView *_topSeparatorView;
  UIView *_bottomSeparatorView;
  UIView *_leftSeparatorView;
  UIView *_rightSeparatorView;
  UILabel *_titleLabel;
  UILabel *_selectionLabel;
}

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    {
      _topSeparatorView = [[UIView alloc] init];
      _topSeparatorView.backgroundColor = [UIColor greenColor];
      [self addSubview:_topSeparatorView];
      
      _bottomSeparatorView = [[UIView alloc] init];
      _bottomSeparatorView.backgroundColor = [UIColor greenColor];
      [self addSubview:_bottomSeparatorView];
      
      _leftSeparatorView = [[UIView alloc] init];
      _leftSeparatorView.backgroundColor = [UIColor greenColor];
      [self addSubview:_leftSeparatorView];
      
      _rightSeparatorView = [[UIView alloc] init];
      _rightSeparatorView.backgroundColor = [UIColor greenColor];
      [self addSubview:_rightSeparatorView];
    }
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = [UIColor darkGrayColor];
    [self addSubview:_titleLabel];
    
    _selectionLabel = [[UILabel alloc] init];
    _selectionLabel.textColor = [UIColor darkGrayColor];
    [self addSubview:_selectionLabel];
  }
  return self;
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  
  CGRect bound = self.bounds;
  
  {// separators
    _topSeparatorView.frame = CGRectMake(CGRectGetMinX(bound),
                                         CGRectGetMinY(bound),
                                         CGRectGetWidth(bound),
                                         1);
    _bottomSeparatorView.frame = CGRectMake(CGRectGetMinX(bound),
                                            CGRectGetMaxY(bound),
                                            CGRectGetWidth(bound),
                                            1);
    _leftSeparatorView.frame = CGRectMake(CGRectGetMinX(bound),
                                          CGRectGetMinY(bound),
                                          1,
                                          CGRectGetHeight(bound));
    _rightSeparatorView.frame = CGRectMake(CGRectGetMaxX(bound)-1,
                                           CGRectGetMinY(bound),
                                           1,
                                           CGRectGetHeight(bound));
  }
  
  {// titileLabel
    if (self.title) {
      _titleLabel.text = self.title;
      _titleLabel.hidden = NO;
      [_titleLabel sizeToFit];
      CGFloat totalPadding = CGRectGetHeight(self.bounds) - CGRectGetHeight(_titleLabel.bounds);
      CGFloat topPadding = totalPadding / 2.0;
      CGFloat originY = topPadding;
      CGFloat leftPadding = 10;;
      _titleLabel.frame = CGRectMake(_titleLabel.bounds.origin.x + leftPadding,
                                     originY,
                                     _titleLabel.bounds.size.width,
                                     _titleLabel.bounds.size.height);
    } else {
      _titleLabel.hidden = YES;
    }
  }
  
  {// selectionLabel
    _selectionLabel.text = @"B";
    [_selectionLabel sizeToFit];
    CGFloat totalPadding = CGRectGetHeight(self.bounds) - CGRectGetHeight(_titleLabel.bounds);
    CGFloat topPadding = totalPadding / 2.0;
    CGFloat originY = topPadding;
    CGFloat rightPadding  = 10;
    _selectionLabel.frame = CGRectMake(CGRectGetMaxX(bound) - _selectionLabel.bounds.size.width - rightPadding,
                                       originY,
                                       _selectionLabel.bounds.size.width,
                                       _selectionLabel.bounds.size.height);
  }
}

@end
