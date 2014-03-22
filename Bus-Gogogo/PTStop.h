//
//  PTStop.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 3/22/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@interface PTStop : NSObject

// full name of bus stop.
@property (nonatomic, copy, readonly) NSString *identifier;

// location of bus stop, derived from coorindate.
@property (nonatomic, strong, readonly) CLLocation *location;

+ (PTStop *)stopAtBayRidgeShoreRoad;

@end
