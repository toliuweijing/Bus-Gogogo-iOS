//
//  PTLinePickerTableViewCell.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 3/22/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const kLinePickerTableViewCellIdentifier;

@class PTLine;

@interface PTLinePickerTableViewCell : UITableViewCell

@property (nonatomic, strong) PTLine *line;

@end
