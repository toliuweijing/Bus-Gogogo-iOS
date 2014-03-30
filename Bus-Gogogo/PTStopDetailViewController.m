//
//  PTStopDetailViewController.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 3/22/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTStopDetailViewController.h"

#import "PTMacro.h"
#import "PTStop.h"
#import "PTStopDetailView.h"

#import "PTStopDetailDownloader.h"
#import "PTStopDetailTableViewCell.h"
#import "PTStopDetailDataSource.h"

@interface PTStopDetailViewController () <PTStopDetailDataSourceDelegate>

@property (nonatomic, strong) PTStop *stop;

@property (nonatomic, strong) PTStopDetailDownloader *downloader;

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) PTStopDetailDataSource *dataSource;

@end

@implementation PTStopDetailViewController

- (instancetype)initWithStop:(PTStop *)stop
{
  if (self = [self initWithNibName:nil bundle:nil]) {
    _stop = stop;
    _downloader = [[PTStopDetailDownloader alloc] initWithStop:stop];
    _dataSource = [[PTStopDetailDataSource alloc] init];
    _dataSource.delegate = self;
    
    self.navigationItem.title = @"Bay Ridge / Shore Road";
  }
  return self;
}

- (void)viewDidAppear:(BOOL)animated
{
  [self.downloader downloadWithCompletionHandler:^(NSArray *vehcileJourneys, NSError *error) {
    DLogFmt(@"num of journeys=%d", vehcileJourneys.count);
    self.dataSource.vehicleJourneys = vehcileJourneys;
    [self.tableView reloadData];
  }];
}

- (void)dataSource:(PTStopDetailDataSource *)dataSource
     configureCell:(UITableViewCell *)cell
          withItem:(PTMonitoredVehicleJourney *)item
{
  PTStopDetailTableViewCell *stopDetailCell = (PTStopDetailTableViewCell *)cell;
  stopDetailCell.vehcileJourney = item;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [self _configureTableView];
}

/**
 Used to configure tableview when created(i.e. in viewDidLoad)
 */
- (void)_configureTableView
{
  self.tableView.dataSource = self.dataSource;
  [self.tableView registerClass:[PTStopDetailTableViewCell class] forCellReuseIdentifier:kCellIdentifier];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}



@end
