//
//  MTADataModelAdaptors.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 3/29/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "MTADataModels.h"

@interface MTAVehicleLocation (Adaptor)

- (CLLocationCoordinate2D)coordinate;

@end
