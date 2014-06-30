//
//  PTStopProtocol.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 6/1/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

@class CLLocation;

@protocol PTStopProtocol <NSObject>

// id
@property (nonatomic, copy, readonly) NSString *identifier;

// stop name.
@property (nonatomic, copy, readonly) NSString *name;

// location of bus stop, derived from coorindate.
@property (nonatomic, strong, readonly) CLLocation *location;

@end
