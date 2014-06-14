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
}

@end

@implementation PTRegionHeaderView

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    // Initialization code
  }
  return self;
}

- (IBAction)_didSelectButton:(UIButton *)sender
{
  NSLog(@"%@", sender.titleLabel.text);
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
