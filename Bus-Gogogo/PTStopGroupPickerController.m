//
//  PTStopGroupPickerController.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 5/29/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTStopGroupPickerController.h"
#import "PTObjectPickerView.h"
#import "PTStopsForRouteDownloader.h"
#import "PTRoute.h"
#import "PTObjectPickerTableViewController.h"

@interface PTStopGroupPickerController () <
  PTObjectPickerViewDelegate,
  PTObjectPickerTableViewController,
  PTStopsForRouteDownloaderDelegate
>

@end

@implementation PTStopGroupPickerController
{
  PTObjectPickerView *_view;
  NSArray *_stopGroups;
  PTRoute *_route;
  PTStopsForRouteDownloader *_downloader;
}

- (UIView *)view
{
  if (_view == nil) {
    _view = [[PTObjectPickerView alloc] init];
    _view.title = @"Direct";
    _view.delegate = self;
  }
  return _view;
}

- (void)setRoute:(PTRoute *)route
{
  _route = route;
  
  // reset
  [self _reset];
  
  _downloader = [[PTStopsForRouteDownloader alloc] initWithRouteIdentifier:_route.identifier delegate:self];
}

- (void)_reset
{
  [_view setSelectionLabelText:@"None"];
  _stopGroups = nil;
}

#pragma mark - PTStopsForRouteDownloaderDelegate

- (void)downloader:(PTStopsForRouteDownloader *)downloader didReceiveStopGroups:(NSArray *)stopGroups
{
  _stopGroups = stopGroups;
}

- (void)downloader:(PTStopsForRouteDownloader *)downloader didReceiveError:(NSError *)error
{
  assert(NO);
}

#pragma mark - PTObjectPickerViewDelegate

- (void)pickerViewDidReceiveTap:(PTObjectPickerView *)pickerView
{
  if (_stopGroups == nil) {
    NSLog(@"%s:wait for network", __FUNCTION__);
    return;
  }
  NSArray *content = @[[(PTStopGroup *)_stopGroups.firstObject name],
                       [(PTStopGroup *)_stopGroups.lastObject name]];
  PTObjectPickerTableViewController *vc = [[PTObjectPickerTableViewController alloc] initWithContent:content];
  vc.delegate = self;
  [self.owner.navigationController pushViewController:vc animated:YES];
}

#pragma mark - PTObjectPickerTableViewController

- (void)objectPickerTableViewController:(PTObjectPickerTableViewController *)controller didFinishWithContent:(NSString *)content
{
  [_view setSelectionLabelText:content];
  
  PTStopGroup *stopGroup;
  if ([[(PTStopGroup *)_stopGroups.firstObject name] isEqualToString:content]) {
    stopGroup = _stopGroups.firstObject;
  } else {
    stopGroup = _stopGroups.lastObject;
  }
  
  [self.delegate stopGroupPickerController:self didFinishWithStopGroup:stopGroup];
  [self.owner.navigationController popViewControllerAnimated:YES];
}

@end
