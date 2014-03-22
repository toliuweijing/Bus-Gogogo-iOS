//
//  PTViewController.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 3/22/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTLinePickerViewController.h"

#import "PTLinePickerDataSource.h"
#import "PTLinePickerTableViewCell.h"

@interface PTLinePickerViewController ()

@property (nonatomic, strong) PTLinePickerDataSource *dataSource;

@end

@implementation PTLinePickerViewController

- (instancetype)init
{
  if (self = [super init]) {
    _dataSource = [[PTLinePickerDataSource alloc] init];
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
	
  [self.tableView registerClass:[PTLinePickerTableViewCell class] forCellReuseIdentifier:kLinePickerTableViewCellIdentifier];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  assert(section == 0);
  return self.dataSource.lines.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  PTLinePickerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLinePickerTableViewCellIdentifier forIndexPath:indexPath];
  assert(cell);
  
  PTLine *line = [self.dataSource lineAtIndexPath:indexPath];
  cell.line = line;
  return cell;
}

@end
