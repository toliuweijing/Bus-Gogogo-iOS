//
//  PTLinePickerTableViewCell.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 3/22/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTLinePickerTableViewCell.h"
#import "PTLine.h"

NSString *const kLinePickerTableViewCellIdentifier = @"line_picker_table_view_cell_identifier";

static const CGFloat kLableLeftPadding = 15.0;

@interface PTLinePickerTableViewCell ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation PTLinePickerTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    _label = [[UILabel alloc] init];
    _label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin;
    [self.contentView addSubview:_label];
    
    self.selectionStyle = UITableViewCellSelectionStyleBlue;
  }
  return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
  [super setSelected:selected animated:animated];
  
  // Configure the view for the selected state
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  
  CGRect frame = self.contentView.bounds;
  frame.size.width = frame.size.width - kLableLeftPadding * 2;
  frame.origin.x = frame.origin.x + kLableLeftPadding;
  self.label.frame = frame;
}

- (void)setLine:(PTLine *)line
{
  _line = line;
  [self _configureWithLine:line];
}

- (void)_configureWithLine:(PTLine *)line
{
  assert(line);
  self.label.text = line.identifier;
}

@end
