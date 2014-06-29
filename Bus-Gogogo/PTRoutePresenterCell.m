//
//  PTRoutePresenterCell.m
//  Bus-Gogogo
//
//  Created by developer on 6/29/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTRoutePresenterCell.h"

@implementation PTRoutePresenterCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (NSString *)reuseIdentifierWithType:(PTRoutePresenterCellType)type
{
  switch (type) {
    case PTRoutePresenterCellTypeBusAtStopTop:
      return @"RoutePresenterCell_BusAtStopTop";
      
    case PTRoutePresenterCellTypeBusAtStopMiddle:
      return @"RoutePresenterCell_BusAtStopMiddle";
      
    case PTRoutePresenterCellTypeBusAtStopBottom:
      return @"RoutePresenterCell_BusAtStopBottom";
      
    case PTRoutePresenterCellTypeBusDriving:
      return @"RoutePresenterCell_BusDriving";
      
    case PTRoutePresenterCellTypeStopTop:
      return @"RoutePresenterCell_top";
      
    case PTRoutePresenterCellTypeStopMiddle:
      return @"RoutePresenterCell_middle";
    
    case PTRoutePresenterCellTypeStopBottom:
      return @"RoutePresenterCell_bottom";
      
    default:
      break;
  }
  assert(NO);
  return nil;
}

@end
