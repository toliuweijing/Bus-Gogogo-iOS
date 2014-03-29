//
//  PTBusMapOverlay.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 3/29/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@class PTBus;

@interface PTBusMapOverlay : NSObject <MKOverlay>

- (instancetype)initWithBus:(PTBus *)bus;

@property (nonatomic, strong) MKCircle *circle;

//@property (nonatomic, strong) PTBus *bus;

@end
