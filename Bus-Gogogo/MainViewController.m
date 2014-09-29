//
//  MainControllerViewController.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 9/27/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "MainViewController.h"
#import "PTMainTableViewCell.h"
#import "PTBase.h"
#import "PTDownloadTask.h"
#import "PTStopsForLocationRequester.h"
#import "PTStopMonitoringDownloadRequester.h"

static const NSString *kMainTableViewCellIdentifier = @"MainTableViewCell";
typedef enum : NSUInteger {
  MainTableViewCellTagLeftHead = 10,
  MainTableViewCellTagTitle,
  MainTableViewCellTagSubtitle,
} MainTableViewCellTag;

@interface MainViewController () <
  CLLocationManagerDelegate,
  UITableViewDataSource,
  UITableViewDelegate
>
{
  __weak IBOutlet UITableView *_tableView;
  
  CLLocationManager *_locationManager;
  CLLocation *_location;
  
  NSArray *_routeStopPairs;
}

@end

@implementation MainViewController

- (void)awakeFromNib
{
  [super awakeFromNib];
  
  _locationManager = [CLLocationManager new];
  _locationManager.delegate = self;
  
  [self _startPollLocation];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  _tableView.tableFooterView = [UIView new];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return _routeStopPairs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  PTMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PTMainTableViewCell class])];
  RouteStopPair *pair = [_routeStopPairs objectAtIndex:indexPath.row];
  cell.head.text = pair.route.shortName;
  cell.head.textColor = pair.route.textColor;
  cell.head.backgroundColor = pair.route.color;
  //TODO:Still couldn't get the destination
  cell.title.text = [@"To " stringByAppendingString:[pair.route.destinations objectAtIndex:pair.stop.directionText.length % 2]];
  
  NSArray *component = @[[PTBase distanceStringBetweenA:_location b:pair.stop.location],
                         pair.stop.directionText,
                         pair.stop.name];
  cell.subtitle.text = [component componentsJoinedByString:@", "];
  return cell;
}

#pragma mark - private

- (void)_fetchStopsForLocation:(CLLocation *)location
{
  [PTDownloadTask
   scheduledTaskWithRequester:[[PTStopsForLocationRequester alloc] initWithLocation:location]
   callback:^(PTStopsForLocationRequester *requester, NSError *error) {
     assert(!error);
     _routeStopPairs = [self _sortRouteStopPairsByDistance:requester.routeStopPairs];
     [_tableView reloadData];
   }];
}

- (void)_fetchStopMonitoringData:(NSArray *)stopIds
{
  for (NSString *identifier in stopIds) {
    [PTDownloadTask scheduledTaskWithRequester:
     [[PTStopMonitoringDownloadRequester alloc] initWithStopId:identifier routeId:nil]
                                      callback:
     ^(PTStopMonitoringDownloadRequester *requester, NSError *error) {
       assert(!error);
       [requester monitoredJourneys];
     }];
  }
}

- (NSArray *)_sortRouteStopPairsByDistance:(NSArray *)routeStopPairs
{
  // routeId, direction,
  routeStopPairs = [routeStopPairs sortedArrayUsingComparator:^NSComparisonResult(RouteStopPair *a, RouteStopPair *b) {
    if ([a.route.identifier isEqualToString:b.route.identifier]) {
      if ([a.stop.directionText isEqualToString:b.stop.directionText]) {
        return fabs([a.stop.location distanceFromLocation:_location]) >
          fabs([b.stop.location distanceFromLocation:_location]);
      }
      return [a.stop.directionText compare:b.stop.directionText];
    }
    return [a.route.identifier compare:b.route.identifier];
  }];
  
  NSMutableArray *tmp = [NSMutableArray new];
  for (RouteStopPair *p in routeStopPairs) {
    RouteStopPair *q = tmp.lastObject;
    if (![p.route.identifier isEqualToString:q.route.identifier] &&
        ![p.stop.directionText isEqualToString:q.stop.directionText]) {
      [tmp addObject:p];
    }
  }
  return tmp;
}

- (void)_startPollLocation
{
  _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
  [_locationManager startUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
  _location = locations.firstObject;
  [manager stopUpdatingLocation];
  if (locations.firstObject) {
    [self _fetchStopsForLocation:locations.firstObject];
  }
}

@end
