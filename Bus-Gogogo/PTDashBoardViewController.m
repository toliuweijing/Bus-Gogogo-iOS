//
//  PTDashBoardViewController.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 5/3/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTDashBoardViewController.h"
#import "PTDashBoardView.h"

@interface PTDashBoardViewController ()
{
  
}

@end

@implementation PTDashBoardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)loadView
{
  self.view = [[PTDashBoardView alloc] initWithFrame:CGRectZero];
}

- (void)viewWillLayoutSubviews
{
  [super viewWillLayoutSubviews];
  [((PTDashBoardView *)self.view) setTopLayoutGuide:self.topLayoutGuide.length];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
