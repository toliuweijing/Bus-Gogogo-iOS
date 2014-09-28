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
#import "PTDownloadTask.h"
#import "PTStopsForLocationRequester.h"

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
  return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  PTMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PTMainTableViewCell class])];
  cell.head.titleLabel.text = @"B";
  cell.title.text = @"To Kings Plaza";
  return cell;
}

#pragma mark - private

- (void)_fetchStopsForLocation:(CLLocation *)location
{
  [PTDownloadTask
   scheduledTaskWithRequester:[[PTStopsForLocationRequester alloc] initWithLocation:location]
   callback:^(NSArray *obaStops, NSError *error) {
     assert(!error);
     NSLog(@"done");
   }];
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
  [manager stopUpdatingLocation];
  if (locations.firstObject) {
    [self _fetchStopsForLocation:locations.firstObject];
  }
}

@end
