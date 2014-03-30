//
//  PTStopDetailTableViewCell.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 3/30/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTStopDetailTableViewCell.h"

#import "PTMonitoredVehicleJourney.h"
#import "PTMacro.h"

@interface PTStopDetailTableViewCell ()


@end

@implementation PTStopDetailTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    // Initialization code
  }
  return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
  [super setSelected:selected animated:animated];
  
  // Configure the view for the selected state
}

- (void)setVehcileJourney:(PTMonitoredVehicleJourney *)vehcileJourney
{
  _vehcileJourney = vehcileJourney;
  [self _configure];
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  
  const CGFloat kHeightEdgePadding = 2.0;
  CGRect frame = self.imageView.frame;
  frame.origin.y += kHeightEdgePadding;
  frame.size.height -= kHeightEdgePadding;
  self.imageView.frame = frame;
}

/**
 configure with/out vehcileJourney
 */
- (void)_configure
{
  NSString *const imageURL = @"Shuttle-Picture.png";
//  self.imageView.image = [UIImage imageNamed:imageURL];
  self.thumbnailView.image = [UIImage imageNamed:imageURL];
//  self.textLabel.text = self.vehcileJourney.oneLiner;
  self.distanceDetailsLabel.text = self.vehcileJourney.oneLiner;
  self.destinationLabel.text = self.vehcileJourney.destinationName;
}

@end

extern NSString *kStopDetailTableViewCellClassName()
{
  static NSString *name;
  if (name == nil) {
    name = NSStringFromClass([PTStopDetailTableViewCell class]);
  }
  return name;
}

extern CGFloat kStopDetailTableViewCellHeight()
{
  return 68;
}