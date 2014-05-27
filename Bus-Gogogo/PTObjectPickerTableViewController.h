//
//  PTObjectPickerTableViewController.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 5/27/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PTObjectPickerTableViewController;

@protocol PTObjectPickerTableViewController <NSObject>

- (void)objectPickerTableViewController:(PTObjectPickerTableViewController *)controller
                   didFinishWithContent:(NSString *)content;

@end

@interface PTObjectPickerTableViewController : UITableViewController

@property (nonatomic, weak) id<PTObjectPickerTableViewController> delegate;

/**
 A list of NSString Objects
 */
- (id)initWithContent:(NSArray *)content;

@end
