//
//  PTMonitoredVehicleJourney.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 3/29/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTMonitoredVehicleJourney.h"
#import "MTADataModelAdaptors.h"

@interface PTMonitoredVehicleJourney ()

@property (nonatomic, strong) MTAMonitoredVehicleJourney *mta;

@end

@implementation PTMonitoredVehicleJourney

- (instancetype)initWithMTACounterPart:(MTAMonitoredVehicleJourney *)mtaCounterPart
{
  if (self = [super init]) {
    _mta = mtaCounterPart;
  }
  return self;
}

- (CLLocationCoordinate2D)coordinate
{
  return self.mta.VehicleLocation.coordinate;
}

- (NSString *)stopPointName
{
  return self.mta.MonitoredCall.StopPointName;
}

- (NSInteger)stopsFromCall
{
  return [self.mta.MonitoredCall.Extensions.Distances.StopsFromCall integerValue];
}

- (NSString *)presentableDistance
{
  return self.mta.MonitoredCall.Extensions.Distances.PresentableDistance;
}

- (NSString *)lineName
{
  return self.mta.PublishedLineName;
}

- (NSString *)destinationName
{
  return self.mta.DestinationName;
}

- (NSString *)oneLiner
{
  return [NSString stringWithFormat:@"%@ is %d stops away",
          self.lineName,
          self.stopsFromCall];
}

@end
