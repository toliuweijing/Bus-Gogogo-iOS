//
//  PTRoutePickerViewController.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 6/7/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTRoutePickerViewController.h"
#import "PTRouteSummaryCell.h"
#import "PTRouteSummaryCell.h"
#import "PTRouteFilter.h"
#import "PTRouteStore.h"
#import "PTRoute.h"

@interface PTRoutePickerViewController ()
{
  __weak IBOutlet PTRegionHeaderView *_regionHeaderView;
  __weak IBOutlet UITableView *_tableView;

  PTRouteFilter *_routeFilter;
}

@end

@implementation PTRoutePickerViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
  if (self = [super initWithCoder:aDecoder]) {
    [self _onInit];
  }
  return self;
}

- (void)_onInit
{
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [[PTRouteStore sharedStore] retrieveRoutes:^(NSArray *routes) {
    _routeFilter = [[PTRouteFilter alloc] initWithRoutes:routes];
    [self _setSelectedRegion:[_regionHeaderView selectedRegion]];
  }];
}

- (void)_setSelectedRegion:(NSString *)region
{
  assert(_routeFilter);
  [_routeFilter filterByRegion:region];
  [_tableView reloadData];
}

- (NSString *)_region
{
  return [_regionHeaderView selectedRegion];
}

- (NSString *)_lineAtRow:(int)row
{
  return [[_routeFilter lines] objectAtIndex:row];
}

- (PTRoute *)_routeAtRow:(int)row
{
  return [_routeFilter routeWithRegion:[self _region]
                                  line:[self _lineAtRow:row]];
}

#pragma mark - PTRegionHeaderViewDelegate

- (void)regionHeaderView:(PTRegionHeaderView *)view
      selectionDidChange:(NSString *)selection
{
  [self _setSelectedRegion:selection];
}

#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSString *identifier = indexPath.row % 2 == 0 ?
  [PTRouteSummaryCell whiteGreenIdentifier] :
  [PTRouteSummaryCell greenGrayIdentifier];
  
  PTRouteSummaryCell *cell = [tableView
                              dequeueReusableCellWithIdentifier:identifier
                              forIndexPath:indexPath];
  assert([cell isKindOfClass:[PTRouteSummaryCell class]]);
  
  PTRoute *route = [self _routeAtRow:indexPath.row];
  cell.leftLabel.text = route.shortName;
  cell.destinationLabel.text = route.longName;
  cell.subtitleLabel.text = route.viaDescription;
  
  return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [_routeFilter lines].count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSLog(@"selected %@", [self _routeAtRow:indexPath.row].shortName);
  [self.delegate
   routePickerViewController:self
   didFinishWithRoute:[self _routeAtRow:indexPath.row]];
}

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
