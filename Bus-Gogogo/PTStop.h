//
//  PTStop.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 3/22/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "OBADataModel.h"

@interface PTStop : NSObject

- (instancetype)initWithOBAStop:(OBAStop *)obaStop;

// id
@property (nonatomic, copy, readonly) NSString *identifier;

// stop name.
@property (nonatomic, copy, readonly) NSString *name;

// location of bus stop, derived from coorindate.
@property (nonatomic, strong, readonly) CLLocation *location;

@end
