//
//  PTRouteDashboardViewController.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 6/7/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTRouteDashboardViewController.h"
#import "PTRoutePresenterController.h"

@interface PTRouteDashboardViewController ()
{
  __weak IBOutlet UIView *_presenterContainerView;
  
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

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  _presenterController = [[PTRoutePresenterController alloc] init];
  
  [_presenterContainerView addSubview:[_presenterController view]];
  [_presenterController view].frame = _presenterContainerView.bounds;
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
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
