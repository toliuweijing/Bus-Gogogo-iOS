//
//  PTRoutePresenterController.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 5/30/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

@class PTStopGroup;
@class PTRoute;

typedef NS_ENUM(NSInteger, PTRoutePresenterViewMode) {
  PTRoutePresenterViewModeMap = 1,
  PTRoutePresenterViewModeList,
};

@interface PTRoutePresenterController : NSObject

@property (nonatomic, assign) PTRoutePresenterViewMode mode;

- (UIView *)view;

- (void)setRoute:(PTRoute *)route;
- (void)setRoute:(PTRoute *)route direction:(int)direction;

- (void)setStopGroup:(PTStopGroup *)stopGroup;

- (void)_setVehicleJourneys:(NSArray *)vehicleJourneys;

@end
