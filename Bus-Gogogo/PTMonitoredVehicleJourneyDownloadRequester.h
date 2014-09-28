//
//  PTMonitoredVehicleJourneyDownloadRequester.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 6/8/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTDownloadTask.h"

@interface PTMonitoredVehicleJourneyDownloadRequester : NSObject <PTDownloadRequester>

- (instancetype)initWithRouteId:(NSString *)routeId;

- (NSArray *)ptMonitoredVehicleJourney;

@end
