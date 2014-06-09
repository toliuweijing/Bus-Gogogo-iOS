//
//  PTRegionHeaderView.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 6/7/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTRegionHeaderView.h"

@interface PTRegionHeaderView ()
{
  IBOutletCollection(UIButton) NSArray *_buttons;
  UIButton *_selected;
}

@end

@implementation PTRegionHeaderView

- (id)initWithCoder:(NSCoder *)aDecoder
{
  if (self = [super initWithCoder:aDecoder]) {
    [self _didSelectButton:[_buttons firstObject]];
  }
  return self;
}

- (IBAction)_didSelectButton:(UIButton *)sender
{
  if (_selected != sender) {
    [self _swapButtonColor:sender];
    [self _swapButtonColor:_selected];
    _selected = sender;
    
    [self.delegate
     view:self
     selectedRegion:_selected.titleLabel.text];
  }
}

- (void)_swapButtonColor:(UIButton *)button
{
  UIColor *color = [button titleColorForState:UIControlStateNormal];
  [button setTitleColor:[button backgroundColor]
               forState:UIControlStateNormal];
  button.backgroundColor = color;
}

+ (PTRegionHeaderView *)loadNibWithOwner:(id)owner
{
  PTRegionHeaderView *view = [[[NSBundle mainBundle]
                              loadNibNamed:@"PTRegionHeaderView"
                              owner:owner
                              options:nil] firstObject];
  return view;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
