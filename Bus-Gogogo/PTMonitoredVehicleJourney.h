//
//  PTMonitoredVehicleJourney.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 3/29/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "PTMonitoredVehicleJourneyProtocol.h"

@class MTAMonitoredVehicleJourney;

@interface PTMonitoredVehicleJourney : NSObject <MKAnnotation, PTMonitoredVehicleJourneyProtocol>

- (instancetype)initWithMTACounterPart:(MTAMonitoredVehicleJourney *)mtaCounterPart;

@end
