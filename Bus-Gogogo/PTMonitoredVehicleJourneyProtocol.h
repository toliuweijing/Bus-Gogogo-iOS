//
//  PTMonitoredVehicleJourneyProtocol.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 6/1/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

@protocol PTMonitoredVehicleJourneyProtocol <NSObject>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

@property (nonatomic, readonly) NSString *stopPointName;

@property (nonatomic, readonly) NSString *stopPointRef;

@property (nonatomic, readonly) NSInteger stopsFromCall;

@property (nonatomic, readonly) NSString *presentableDistance;

@property (nonatomic, readonly) NSString *oneLiner;

@property (nonatomic, readonly) NSString *lineName;

@property (nonatomic, readonly) NSString *destinationName;

@property (nonatomic, readonly) int direction;

@end
