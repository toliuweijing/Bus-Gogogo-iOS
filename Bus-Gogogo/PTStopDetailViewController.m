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

#import "PTStopDetailDownloader.h"

@interface PTStopDetailViewController ()

@property (nonatomic, strong) PTStop *stop;

@property (nonatomic, strong) PTStopDetailDownloader *downloader;

@property (nonatomic, strong) PTStopDetailView *stopDetailView;

@end

@implementation PTStopDetailViewController

- (instancetype)initWithStop:(PTStop *)stop
{
  if (self = [super init]) {
    _stop = stop;
    _downloader = [[PTStopDetailDownloader alloc] initWithStop:stop];
  }
  return self;
}

- (void)loadView
{
  self.stopDetailView = [[PTStopDetailView alloc] initWithFrame:CGRectZero stop:self.stop line:self.line];
  self.view = self.stopDetailView;
}

- (void)viewDidAppear:(BOOL)animated
{
  [self.downloader
   downloadWithSuccessBlock:^(NSArray *locations) {
     self.stopDetailView.locations = locations;
     NSLog(@"%@", locations);
   }
   failureBlock:nil];
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
