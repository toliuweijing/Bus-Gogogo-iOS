//
//  PTListContainerView.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 5/30/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTListContainerView.h"
#import "PTStopGroup.h"
#import "PTMonitoredVehicleJourney.h"
#import "PTStore.h"
#import "PTStop.h"
#import "PTBase.h"


@interface PTListContainerView () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation PTListContainerView
{
  UITableView *_tableView;
  PTStopGroup *_stopGroup;
  NSArray *_vehicleJourneys;
}

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self addSubview:_tableView];
  }
  return self;
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  _tableView.frame = self.bounds;
}

- (void)setStopGroup:(PTStopGroup *)stopGroup vehicleJourneys:(NSArray *)vehicleJourneys
{
  _stopGroup = stopGroup;
  _vehicleJourneys = vehicleJourneys;
  [_tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *identifier = @"PTListContainerView";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
  }
  
  NSString *stopID = [_stopGroup.stopIDs objectAtIndex:indexPath.row];
  
  PTStop *stop = [[PTStore sharedStore] stopWithIdentifier:stopID];
  PTMonitoredVehicleJourney *journey = [self _journeyAtStop:stopID];
  [self _configureCell:cell withVehicleJourney:journey stop:stop];
  
  return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  assert(section == 0);
  return _stopGroup.stopIDs.count;
}

#pragma mark - Private

- (PTMonitoredVehicleJourney *)_journeyAtStop:(NSString *)stopID
{
  for (PTMonitoredVehicleJourney *journey in _vehicleJourneys) {
    if ([journey.stopPointRef isEqualToString:stopID] &&
         journey.direction == _stopGroup.direction) {
      return journey;
    }
  }
  return nil;
}

- (void)_configureCell:(UITableViewCell *)cell
    withVehicleJourney:(PTMonitoredVehicleJourney *)journey
                  stop:(PTStop *)stop
{
  assert(stop); // should have a valid stop for each cell.
  
  cell.textLabel.text = stop.name;
  cell.textLabel.font = [PTBase font];
  if (journey) {
    cell.detailTextLabel.text = journey.presentableDistance;
    cell.imageView.image = [UIImage imageNamed:[PTBase shuttlePictureImageName]];
  } else {
    cell.detailTextLabel.text = nil;
    cell.imageView.image = nil;
  }
  cell.detailTextLabel.font = [PTBase font];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSString *stopID = [_stopGroup.stopIDs objectAtIndex:indexPath.row];
  PTMonitoredVehicleJourney *journey = [self _journeyAtStop:stopID];
  if (journey) {
    return 60;
  } else {
    return 30;
  }
}

@end