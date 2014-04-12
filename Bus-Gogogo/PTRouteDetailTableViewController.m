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
#import "PTRouteDetailTableViewCell.h"
#import "PTStore.h"
#import "PTMonitoredVehicleJourney.h"
#import "PTMonitoredVehicleJourneyDownloader.h"

static NSString *const kCellIdentifier = @"cell_identifier";

static NSString *const kShuttlePictureImageName = @"Shuttle-Picture.png";

@interface PTRouteDetailTableViewController () <
PTStopsForRouteDownloaderDelegate,
PTMonitoredVehicleJourneyDownloaderDelegate,
MKMapViewDelegate>

@property (nonatomic, strong) PTStopsForRouteDownloader *stopsForRouteDownloader;

@property (nonatomic, strong) PTMonitoredVehicleJourneyDownloader *vehicleJourneyDownloader;

@property (nonatomic, strong) NSArray *vehcleJourneys;

@property (nonatomic, strong) NSArray *stopGroups; // with 2 directions

@property (nonatomic, strong) PTStopGroup *stopGroup; // current stop group

@property (nonatomic, strong) NSArray *circleOverlays; // circle Overlays

@property (nonatomic, strong) MKPolyline *polylineOverlays;

@property (nonatomic, strong) MKMapView *mapView;

@end

@implementation PTRouteDetailTableViewController

- (id)init
{
  assert(NO);
}

- (instancetype)initWithStyle:(UITableViewStyle)style
              routeIdentifier:(NSString *)routeIdentifier
{
  self = [super initWithStyle:style];
  if (self) {
    _stopsForRouteDownloader = [[PTStopsForRouteDownloader alloc] initWithRouteIdentifier:routeIdentifier];
    _stopsForRouteDownloader.delegate = self;
    
    _vehicleJourneyDownloader = [[PTMonitoredVehicleJourneyDownloader alloc] initWithRouteIdentifier:routeIdentifier];
    _vehicleJourneyDownloader.delegate = self;
    
    UIBarButtonItem *direction = [[UIBarButtonItem alloc] initWithTitle:@"Direction"
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:@selector(_didTapDirection:)];
    UIBarButtonItem *list = [[UIBarButtonItem alloc] initWithTitle:@"List"
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(_didTapSwitchPresentation:)];
    self.navigationItem.rightBarButtonItems = @[direction, list];
  }
  return self;
}

/**
 Switch between MapView and TableView
 */
- (void)_didTapSwitchPresentation:(id)sender
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

- (void)_didTapDirection:(id)sender
{
  // switch stopGroups order
  if (self.stopGroup == self.stopGroups.firstObject) {
    self.stopGroup = self.stopGroups.lastObject;
  } else {
    self.stopGroup = self.stopGroups.firstObject;
  }
  // retrieve vehicle journeys
  [self.vehicleJourneyDownloader startDownload];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  [self.stopsForRouteDownloader startDownload];
  [self.vehicleJourneyDownloader startDownload];
  [NSTimer scheduledTimerWithTimeInterval:60
                                   target:self
                                 selector:@selector(_fireVehicleJourneyDownloader:)
                                 userInfo:nil
                                  repeats:YES];
}

- (void)_fireVehicleJourneyDownloader:(NSTimer *)timer
{
  [self.vehicleJourneyDownloader startDownload];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  // configure tableview
  [self.tableView registerClass:[PTRouteDetailTableViewCell class] forCellReuseIdentifier:kCellIdentifier];
  
  // configure mapview
  _mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
  _mapView.showsUserLocation = YES;
  _mapView.delegate = self;
  [self.view addSubview:_mapView];
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

#pragma mark - Getters/setters

- (void)setVehcleJourneys:(NSArray *)vehcleJourneys
{
  _vehcleJourneys = vehcleJourneys;
  [self.tableView reloadData];
}

- (void)setStopGroups:(NSArray *)stopGroups
{
  assert(stopGroups.count == 2);
  _stopGroups = stopGroups;
  self.stopGroup = stopGroups.firstObject;
}

- (void)setStopGroup:(PTStopGroup *)stopGroup
{
  _stopGroup = stopGroup;
  [self _configureMapViewWithStopGroup:stopGroup];
  self.navigationItem.title = stopGroup.name;
  [self.tableView reloadData];
}

#pragma mark -
#pragma mark PTMonitoredVehicleJourneyDownloaderDelegate

- (void)downloader:(PTMonitoredVehicleJourneyDownloader *)downloader didReceiveVehicleJourneys:(NSArray *)vehicleJourneys
{
  self.vehcleJourneys = vehicleJourneys;
  [self _configureMapViewWithVehicleJourneys:vehicleJourneys];
}

- (void)_configureMapViewWithVehicleJourneys:(NSArray *)vechileJourneys
{
  [self.mapView removeOverlays:self.circleOverlays];
  
  NSMutableArray *collection = [[NSMutableArray alloc] init];
  for (PTMonitoredVehicleJourney *journey in vechileJourneys) {
    // only show journeys of the same direction.
    if (journey.direction == self.stopGroup.direction) {
      MKCircle *circle = [MKCircle circleWithCenterCoordinate:journey.coordinate radius:10];
      [collection addObject:circle];
    }
  }
  self.circleOverlays = collection;
  [self.mapView addOverlays:collection];
}

#pragma mark -
#pragma mark PTStopsForRouteDownloaderDelegate

- (void)downloader:(PTStopsForRouteDownloader *)downloader didReceiveError:(NSError *)error
{
  
}

- (void)downloader:(PTStopsForRouteDownloader *)downloader didReceiveStopGroups:(NSArray *)stopGroups
{
  self.stopGroups = stopGroups;
}

- (void)_configureMapViewWithStopGroup:(PTStopGroup *)stopGroup
{
  [self.mapView removeOverlay:self.polylineOverlays];
  
  NSInteger count = stopGroup.polylinePoints.count;
  CLLocationCoordinate2D coordinates[count];
  for (int i = 0 ; i < count ; ++i) {
    coordinates[i] = [[stopGroup.polylinePoints objectAtIndex:i] coordinate];
  }
  MKPolyline *polyline = [MKPolyline polylineWithCoordinates:coordinates count:count];
  self.polylineOverlays = polyline;
  [self.mapView addOverlay:polyline];
  self.mapView.region = [self.stopGroup coordinateRegion];
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
}

#pragma mark - MKMapViewDelegate

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
  if ([overlay isKindOfClass:[MKCircle class]]) {
    MKCircleRenderer *renderer = [[MKCircleRenderer alloc] initWithOverlay:overlay];
    renderer.fillColor = [UIColor grayColor];
    renderer.strokeColor = [UIColor blueColor];
    renderer.lineWidth = 5.0;
    return renderer;
  } else if ([overlay isKindOfClass:[MKPolyline class]]) {
    MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    renderer.strokeColor = [UIColor redColor];
    renderer.lineWidth = 3.0;
    return renderer;
  }
  assert(false);
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
  
  PTStop *stop = [[PTStore sharedStore] stopWithIdentifier:stopID];
  PTMonitoredVehicleJourney *journey = [self _journeyAtStop:stopID];
  [self _configureCell:cell withVehicleJourney:journey stop:stop];
  return cell;
}

- (void)_configureCell:(UITableViewCell *)cell
    withVehicleJourney:(PTMonitoredVehicleJourney *)journey
                  stop:(PTStop *)stop
{
  assert(stop); // should have a valid stop for each cell.
  
  cell.textLabel.text = stop.name;
  if (journey) {
    cell.detailTextLabel.text = journey.presentableDistance;
    cell.imageView.image = [UIImage imageNamed:kShuttlePictureImageName];
  } else {
    cell.detailTextLabel.text = nil;
    cell.imageView.image = nil;
  }
}

- (PTMonitoredVehicleJourney *)_journeyAtStop:(NSString *)stopID
{
  for (PTMonitoredVehicleJourney *journey in self.vehcleJourneys) {
    if ([journey.stopPointRef isEqualToString:stopID] &&
         journey.direction == self.stopGroup.direction) {
      return journey;
    }
  }
  return nil;
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
