//
//  PTMapContainerView.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 4/12/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PTStopGroup;
@class PTMonitoredVehicleJourney;

@interface PTMapContainerView : UIView

@property (nonatomic, strong) PTStopGroup *stopGroup;

@property (nonatomic, strong) NSArray *vehicleJourneys;

@end
