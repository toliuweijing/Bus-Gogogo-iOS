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

@interface PTStopDetailViewController () <
PTStopDetailDataSourceDelegate,
UITableViewDelegate>

//@property (nonatomic, strong) PTStop *stop;

@property (nonatomic, strong) PTStopDetailDownloader *downloader;

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, weak) IBOutlet UIBarButtonItem *refreshButton;

@property (nonatomic, strong) PTStopDetailDataSource *dataSource;

@end

@implementation PTStopDetailViewController

- (instancetype)initWithStop:(PTStop *)stop
{
  if (self = [self initWithNibName:nil bundle:nil]) {
//    _stop = stop;
    
    _downloader = [[PTStopDetailDownloader alloc] initWithStop:stop];
    _dataSource = [[PTStopDetailDataSource alloc] init];
    _dataSource.delegate = self;
    
    self.navigationItem.title = @"Bay Ridge / Shore Road";
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc]
                               initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                               target:self
                               action:@selector(_didTapRefresh:)];
    self.navigationItem.rightBarButtonItem = button;
  }
  return self;
}

- (void)dealloc
{
  self.navigationItem.rightBarButtonItem.target = nil;
  self.navigationItem.rightBarButtonItem.action = nil;
}

- (void)_didTapRefresh:(id)sender
{
  [self _updateContent];
}

- (void)_updateContent
{
  [self.downloader downloadWithCompletionHandler:^(NSArray *vehcileJourneys, NSError *error) {
    DLogFmt(@"num of journeys=%d", vehcileJourneys.count);
    self.dataSource.vehicleJourneys = vehcileJourneys;
    [self.tableView reloadData];
  }];
}

- (void)viewDidAppear:(BOOL)animated
{
  [self _updateContent];
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
  self.tableView.delegate = self;
  
  // setup cells
  UINib *nib = [UINib nibWithNibName:kStopDetailTableViewCellClassName() bundle:nil];
  [self.tableView registerNib:nib forCellReuseIdentifier:kStopDetailTableViewCellClassName()];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return kStopDetailTableViewCellHeight();
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return kStopDetailTableViewCellHeight();
}

@end
