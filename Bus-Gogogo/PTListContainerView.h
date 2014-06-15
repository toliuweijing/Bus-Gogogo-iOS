//
//  PTListContainerView.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 5/30/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

@class PTStopGroup;
@class PTRoute;
@class PTMonitoredVehicleJourney;

/**
 A container view that presents realtime info of a given route in a list format.
 */
@interface PTListContainerView : UIView

- (void)setRoute:(PTRoute *)route;

- (void)setStopGroup:(PTStopGroup *)stopGroup
     vehicleJourneys:(NSArray *)vehicleJourneys;

@end
