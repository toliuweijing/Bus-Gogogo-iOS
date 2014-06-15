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
    [self _setupDefaulSelection];
  }
  return self;
}

- (NSString *)selectedRegion
{
  assert([self _isButtonSelected:_selected]);
  return _selected.titleLabel.text;
}

+ (PTRegionHeaderView *)loadNibWithOwner:(id)owner
{
  PTRegionHeaderView *view = [[[NSBundle mainBundle]
                              loadNibNamed:@"PTRegionHeaderView"
                              owner:owner
                              options:nil] firstObject];
  return view;
}

#pragma mark - Private

- (void)_setupDefaulSelection
{
  // Find the first button in subviews and set
  // it as current selection.
  for (UIView *view in self.subviews) {
    if ([view isKindOfClass:[UIButton class]]) {
      UIButton *button = (UIButton *)view;
      if (![self _isButtonSelected:button]) {
        [self _didSelectButton:button];
      }
      _selected = (UIButton *)view;
      break;
    }
  }
}

- (BOOL)_isButtonSelected:(UIButton *)button
{
  assert(button);
  assert(button.backgroundColor != [button titleColorForState:UIControlStateNormal]);
  return button.backgroundColor != [UIColor whiteColor];
}

- (IBAction)_didSelectButton:(UIButton *)sender
{
  if (_selected != sender) {
    [self _swapButtonColor:sender];
    [self _swapButtonColor:_selected];
    _selected = sender;
    
    [self.delegate
     regionHeaderView:self
     selectionDidChange:[self selectedRegion]];
  }
}

- (void)_swapButtonColor:(UIButton *)button
{
  UIColor *color = [button titleColorForState:UIControlStateNormal];
  [button setTitleColor:[button backgroundColor]
               forState:UIControlStateNormal];
  button.backgroundColor = color;
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
