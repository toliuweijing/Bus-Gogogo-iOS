//
//  PTRouteSummaryCell.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 6/8/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTRouteSummaryCell.h"

@implementation PTRouteSummaryCell

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

+ (PTRouteSummaryCell *)loadNibWithOwner:(id)owner
{
  return [[[NSBundle mainBundle]
           loadNibNamed:@"PTRouteSummaryCell"
           owner:owner
           options:nil]
          firstObject];
}

@end
