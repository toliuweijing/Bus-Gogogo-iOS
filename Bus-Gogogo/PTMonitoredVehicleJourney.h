//
//  PTMonitoredVehicleJourney.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 3/29/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class MTAMonitoredVehicleJourney;

@interface PTMonitoredVehicleJourney : NSObject

- (instancetype)initWithMTACounterPart:(MTAMonitoredVehicleJourney *)mtaCounterPart;

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

@property (nonatomic, readonly) NSString *stopPointName;

@property (nonatomic, readonly) NSInteger stopsFromCall;

@property (nonatomic, readonly) NSString *presentableDistance;

@property (nonatomic, readonly) NSString *oneLiner;

@property (nonatomic, readonly) NSString *lineName;

@property (nonatomic, readonly) NSString *destinationName;

@end
