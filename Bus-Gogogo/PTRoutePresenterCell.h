//
//  PTRoutePresenterCell.h
//  Bus-Gogogo
//
//  Created by developer on 6/29/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PTRoutePresenterCellType) {
  PTRoutePresenterCellTypeBusAtStopTop = 0,
  PTRoutePresenterCellTypeBusAtStopMiddle,
  PTRoutePresenterCellTypeBusAtStopBottom,
  PTRoutePresenterCellTypeStopTop,
  PTRoutePresenterCellTypeStopMiddle,
  PTRoutePresenterCellTypeStopBottom,
  PTRoutePresenterCellTypeBusDriving,
};

@interface PTRoutePresenterCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

+ (NSString *)reuseIdentifierWithType:(PTRoutePresenterCellType)type;

@end
