//
//  PTRouteDashboardViewController.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 6/7/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTRouteDashboardViewController.h"
#import "PTRoutePresenterController.h"
#import "PTRoutePickerViewController.h"
#import "PTDashboardRoutePickerView.h"

@interface PTRouteDashboardViewController () <
  PTRoutePickerViewControllerDelegate
>
{
  __weak IBOutlet UIView *_presenterContainerView;
  __weak IBOutlet PTDashboardRoutePickerView *_pickerContainerView;
  
  PTRoute *_route;
  
  PTRoutePresenterController *_presenterController;
}

@end

@implementation PTRouteDashboardViewController

- (id)init
{
  assert(NO);
}

- (void)awakeFromNib
{
}

- (NSString *)_rightBarItemTitle
{
  return _presenterController.mode == PTRoutePresenterViewModeMap ? @"List" : @"Map";
}

- (IBAction)_didTapRightBarItem:(id)sender
{
  if (_presenterController.mode == PTRoutePresenterViewModeMap) {
    _presenterController.mode = PTRoutePresenterViewModeList;
  } else {
    _presenterController.mode = PTRoutePresenterViewModeMap;
  }
  self.navigationItem.rightBarButtonItem.title = [self _rightBarItemTitle];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  _presenterController = [[PTRoutePresenterController alloc] init];
  
  [_presenterContainerView addSubview:[_presenterController view]];
  [_presenterController view].frame = _presenterContainerView.bounds;

}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  if (_route) {
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc]
     initWithTitle:[self _rightBarItemTitle]
     style:UIBarButtonItemStylePlain
     target:self
     action:@selector(_didTapRightBarItem:)];
  }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
  // Get the new view controller using [segue destinationViewController].
  // Pass the selected object to the new view controller.
  if ([segue.identifier
       isEqualToString:@"RoutePickerViewController"]) {
    [(PTRoutePickerViewController *)segue.destinationViewController
     setDelegate:self];
  }
}

- (IBAction)_didTapDirectionPicker:(id)sender
{
  [_pickerContainerView flipDirection];
  [_presenterController setRoute:_route direction:[_pickerContainerView direction]];
}

#pragma mark - PTRoutePickerViewControllerDelegate

- (void)routePickerViewController:(PTRoutePickerViewController *)controller didFinishWithRoute:(PTRoute *)route
{
  _route = route;
  [_pickerContainerView setRoute:route];
  [_presenterController setRoute:route
                       direction:[_pickerContainerView direction]];
  
  [self.navigationController
   popToViewController:self
   animated:YES];
}

@end
