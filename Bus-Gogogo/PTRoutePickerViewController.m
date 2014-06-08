//
//  PTRoutePickerViewController.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 6/7/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTRoutePickerViewController.h"
#import "PTRegionHeaderView.h"
#import "PTRouteSummaryCell.h"

@interface PTRoutePickerViewController () <
  UITableViewDataSource,
  UITableViewDelegate
>
{
  __weak IBOutlet UIView *_regionHeaderContainer;
  
  PTRegionHeaderView *_regionHeader;
  UITableView *_tableView;
}

@end

@implementation PTRoutePickerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  // 1. _regionHeaderContainer contains _regionHeader
  _regionHeader = [PTRegionHeaderView loadNibWithOwner:self];
  _regionHeader.frame = _regionHeaderContainer.bounds;
  [_regionHeaderContainer addSubview:_regionHeader];
  
  // 2. self.view contains _tableView
  _tableView =
  [[UITableView alloc] initWithFrame:
   CGRectMake(0,
              CGRectGetMaxY(_regionHeaderContainer.frame)+1,
              CGRectGetWidth(self.view.bounds),
              CGRectGetHeight(self.view.bounds) - CGRectGetMaxY(_regionHeaderContainer.frame))];
  [_tableView registerNib:[UINib nibWithNibName:@"PTRouteSummaryCell" bundle:nil] forCellReuseIdentifier:@"RouteSummaryCell"];
  _tableView.dataSource = self;
  _tableView.delegate = self;
  [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView
                           dequeueReusableCellWithIdentifier:@"RouteSummaryCell"
                           forIndexPath:indexPath];
  return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 33;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
