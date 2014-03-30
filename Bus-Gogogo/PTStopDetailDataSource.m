//
//  PTStopDetailDataSource.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 3/30/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTStopDetailDataSource.h"
#import "PTMonitoredVehicleJourney.h"
#import "PTStopDetailTableViewCell.h"

@interface PTStopDetailDataSource ()

@end

@implementation PTStopDetailDataSource

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  // only has section #0
  assert(section == 0);
  return self.vehicleJourneys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kStopDetailTableViewCellClassName() forIndexPath:indexPath];
  PTMonitoredVehicleJourney *item = [self itemAtIndexPath:indexPath];
  [self.delegate dataSource:self configureCell:cell withItem:item];
  return cell;
}

- (PTMonitoredVehicleJourney *)itemAtIndexPath:(NSIndexPath *)indexPath
{
  [self _verifySection:indexPath.section];
  return [self.vehicleJourneys objectAtIndex:indexPath.row];
}

- (void)_verifySection:(NSInteger)section
{
  assert(section == 0);
}

@end
