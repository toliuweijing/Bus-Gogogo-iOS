//
//  PTPolyline.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 4/12/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import <MapKit/MapKit.h>

@class OBAPolyline;

@interface PTPolyline : NSObject

- (instancetype)initWithOBACounterPart:(OBAPolyline *)oba;

- (MKPolyline *)mapPolyline;

@end
