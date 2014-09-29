//
//  PTRoutesForLocationRequester.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 9/28/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTDownloadTask.h"
#import <CoreLocation/CoreLocation.h>

#import "PTRoute.h"
#import "PTStop.h"

@interface PTStopsForLocationRequester : NSObject <PTDownloadRequester>

- (instancetype)initWithLocation:(CLLocation *)location;

- (NSArray *)obaRoutes;

@property (nonatomic, readonly) NSArray *routeStopPairs;

@property (nonatomic, readonly) NSArray *stopIds;

@end

@interface RouteStopPair : NSObject

@property (nonatomic, strong) PTRoute *route;
@property (nonatomic, strong) PTStop *stop;

@end