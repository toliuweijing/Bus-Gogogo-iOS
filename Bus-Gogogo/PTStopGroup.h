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

- (MKCoordinateRegion)coordinateRegion;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, assign) int direction;

// PTSTops
@property (nonatomic, strong) NSArray *stopIDs;

// An array of PTPolyline objects.
@property (nonatomic, strong) NSArray *polylines;

// An unordered array of CLLocation objects from self.polylines.
@property (nonatomic, strong) NSArray *polylinePoints;

@end
