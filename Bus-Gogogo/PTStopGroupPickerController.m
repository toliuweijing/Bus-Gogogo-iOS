//
//  PTStopGroupPickerController.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 5/29/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTStopGroupPickerController.h"
#import "PTObjectPickerView.h"
#import "PTStopGroupDownloadRequester.h"
#import "PTDownloadTask.h"
#import "PTStopGroup.h"
#import "PTRoute.h"
#import "PTObjectPickerTableViewController.h"

@interface PTStopGroupPickerController () <
  PTObjectPickerViewDelegate,
  PTObjectPickerTableViewController
>

@end

@implementation PTStopGroupPickerController
{
  PTObjectPickerView *_view;
  NSArray *_stopGroups;
  PTRoute *_route;
  PTDownloadTask *_task;
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
  
  _task = [PTDownloadTask scheduledTaskWithRequester:[[PTStopGroupDownloadRequester alloc] initWithRouteId:_route.identifier] callback:^(NSArray *stopGroups, NSError *error) {
    if (error == nil) {
      _stopGroups = stopGroups;
    } else {
      NSLog(@"%s received error=%@", __FUNCTION__, error);
    }
  }];
}

- (void)_reset
{
  [_view setSelectionLabelText:@"None"];
  _stopGroups = nil;
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
