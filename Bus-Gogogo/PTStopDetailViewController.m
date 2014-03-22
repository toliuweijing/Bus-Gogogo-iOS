//
//  PTStopDetailViewController.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 3/22/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTStopDetailViewController.h"

#import "PTStop.h"
#import "PTStopDetailView.h"

@interface PTStopDetailViewController ()

@property (nonatomic, strong) PTStop *stop;

@end

@implementation PTStopDetailViewController

- (instancetype)initWithStop:(PTStop *)stop
{
  if (self = [super init]) {
    _stop = stop;
  }
  return self;
}

- (void)loadView
{
  self.view = [[PTStopDetailView alloc] initWithFrame:CGRectZero stop:self.stop];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
