//
//  PTStopDetailView.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 3/22/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTStopDetailView.h"

#import <MapKit/MapKit.h>
#import "PTStop+MKAnnotation.h"

@interface PTStopDetailView ()

@property (nonatomic, strong) MKMapView *mapView;

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;

@end

@implementation PTStopDetailView

- (id)initWithFrame:(CGRect)frame stop:(PTStop *)stop
{
  self = [super initWithFrame:frame];
  if (self) {
    _mapView = [PTStopDetailView _mapViewWithStop:stop];
    [self addSubview:_mapView];
    
//    _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    [self addSubview:_activityIndicatorView];
  }
  return self;
}

+ (MKMapView *)_mapViewWithStop:(PTStop *)stop
{
  MKMapView *mapView = [[MKMapView alloc] initWithFrame:CGRectZero];
  [mapView addAnnotation:stop];
  
  mapView.region = MKCoordinateRegionMakeWithDistance(stop.coordinate, 5, 5);
  return mapView;
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  
  _mapView.frame = self.bounds;
  _activityIndicatorView.center = self.center;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
