//
//  PTRouteDetailTableViewController.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 4/4/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTRouteDetailTableViewController.h"
#import "PTStopsForRouteDownloader.h"
#import "PTStop.h"

static NSString *const kCellIdentifier = @"cell_identifier";

@interface PTRouteDetailTableViewController () <
PTStopsForRouteDownloaderDelegate,
MKMapViewDelegate>

@property (nonatomic, strong) PTStopsForRouteDownloader *downloader;

@property (nonatomic, strong) PTStopGroup *stopGroup;

@property (nonatomic, strong) MKMapView *mapView;

@end

@implementation PTRouteDetailTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
  self = [super initWithStyle:style];
  if (self) {
    _downloader = [[PTStopsForRouteDownloader alloc] init];
    _downloader.delegate = self;
    
    self.navigationItem.title = @"B9";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                              target:self
                                              action:@selector(_didTapRefresh:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                                             initWithTitle:@"List"
                                             style:UIBarButtonItemStylePlain
                                             target:self
                                             action:@selector(_didTapSwitch:)];
  }
  return self;
}

- (void)_didTapSwitch:(id)sender
{
  if ([self.view.subviews containsObject:self.mapView]) {
    [self.mapView removeFromSuperview];
    self.navigationItem.leftBarButtonItem.title = @"Map";
  } else {
    [self.view addSubview:self.mapView];
    self.navigationItem.leftBarButtonItem.title = @"List";
  }
  [self.view setNeedsDisplay];
}

- (void)_didTapRefresh:(id)sender
{
  [self.downloader startDownload];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  [self.downloader startDownload];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];
  
  _mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
//  _mapView.showsUserLocation = YES;
//  _mapView.userTrackingMode = MKUserTrackingModeFollow;
  _mapView.delegate = self;
  [self.view addSubview:_mapView];
  // Uncomment the following line to preserve selection between presentations.
  // self.clearsSelectionOnViewWillAppear = NO;
  
  // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
  // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillLayoutSubviews
{
  [super viewWillLayoutSubviews];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark PTStopsForRouteDownloaderDelegate

- (void)downloader:(PTStopsForRouteDownloader *)downloader didReceiveError:(NSError *)error
{
  
}

- (void)downloader:(PTStopsForRouteDownloader *)downloader didReceiveStopGroup:(PTStopGroup *)stopGroup
{
  self.stopGroup = stopGroup;
  [self _configureMapViewWithStopGroup:stopGroup];
  [self.tableView reloadData];

}
- (void)_configureMapViewWithStopGroup:(PTStopGroup *)stopGroup
{
  NSInteger count = stopGroup.polylinePoints.count;
  CLLocationCoordinate2D coordinates[count];
  for (int i = 0 ; i < count ; ++i) {
    coordinates[i] = [[stopGroup.polylinePoints objectAtIndex:i] coordinate];
  }
  MKPolyline *polyline = [MKPolyline polylineWithCoordinates:coordinates count:count];
  [self.mapView addOverlay:polyline];
  self.mapView.region = [self.stopGroup coordinateRegion];
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
}

#pragma mark - MKMapViewDelegate

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
  MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
  renderer.strokeColor = [UIColor blueColor];
  renderer.lineWidth = 3.0;
  return renderer;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  assert(section == 0);
  return self.stopGroup.stopIDs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
  
  NSString *stopID = [self.stopGroup.stopIDs objectAtIndex:indexPath.row];
  cell.textLabel.text = stopID;
  
  return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

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