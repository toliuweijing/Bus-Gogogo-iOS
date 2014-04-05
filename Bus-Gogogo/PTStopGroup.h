//
//  PTRoute.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 4/5/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "OBADataModel.h"
#import "PTStop.h"

@interface PTStopGroup : NSObject

+ (PTStopGroup *)stopGroupFromOBACounterPart:(OBAStopGroup *)oba;

@property (nonatomic, strong) NSString *name;

// PTSTops
@property (nonatomic, strong) NSArray *stopIDs;

// points for drawing PTRoute
@property (nonatomic, strong) NSArray *polylinePoints;

@end
