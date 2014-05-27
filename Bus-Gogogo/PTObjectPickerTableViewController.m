//
//  PTObjectPickerTableViewController.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 5/27/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTObjectPickerTableViewController.h"

@interface PTObjectPickerTableViewController ()

@end

@implementation PTObjectPickerTableViewController
{
  NSArray *_content;
}

- (id)initWithContent:(NSArray *)content
{
  if (self = [super initWithStyle:UITableViewStylePlain]) {;
    _content = content;
  }
  return self;
}

- (id)init
{
  assert(NO);
  return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
  assert(NO);
  return self;
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews
{
  [super viewWillLayoutSubviews];
  self.tableView.contentInset = UIEdgeInsetsMake(self.topLayoutGuide.length, 0, 0, 0);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return _content.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *kIdentifier = @"identifier";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kIdentifier];
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kIdentifier];
  }
  cell.textLabel.text = [_content objectAtIndex:indexPath.row];
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSString *content = [_content objectAtIndex:indexPath.row];
  [self.delegate objectPickerTableViewController:self
                            didFinishWithContent:content];
}

@end
