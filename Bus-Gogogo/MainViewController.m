//
//  MainControllerViewController.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 9/27/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "MainViewController.h"
#import <MapKit/MapKit.h>
#import "PTMainTableViewCell.h"

static const NSString *kMainTableViewCellIdentifier = @"MainTableViewCell";
typedef enum : NSUInteger {
  MainTableViewCellTagLeftHead = 10,
  MainTableViewCellTagTitle,
  MainTableViewCellTagSubtitle,
} MainTableViewCellTag;

@interface MainViewController () <
  UITableViewDataSource,
  UITableViewDelegate
>
{
  __weak IBOutlet UITableView *_tableView;
}

@end

@implementation MainViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  _tableView.tableFooterView = [UIView new];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  PTMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PTMainTableViewCell class])];
  cell.head.titleLabel.text = @"B";
  cell.title.text = @"To Kings Plaza";
  return cell;
}
@end
