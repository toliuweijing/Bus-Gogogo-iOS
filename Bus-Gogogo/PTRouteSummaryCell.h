//
//  PTRouteSummaryCell.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 6/8/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTRouteSummaryCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *destinationLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;

+ (PTRouteSummaryCell *)loadNibWithOwner:(id)owner;

+ (NSString *)whiteGreenIdentifier;
+ (NSString *)greenGrayIdentifier;

@end
