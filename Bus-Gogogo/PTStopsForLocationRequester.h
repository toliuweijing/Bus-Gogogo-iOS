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

// PTStops
@property (nonatomic, readonly) NSArray *stops;

@end
