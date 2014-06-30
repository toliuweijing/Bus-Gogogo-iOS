//
//  PTRouteFilter.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 5/28/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PTStopGroup;
@class PTRoute;

/**
 PTRouteFilter helps with PTRoute picking process. It provides filtering functionality 
 based on user input, i.e. region, line, direction.
 */
@interface PTRouteFilter : NSObject

// param routes a list of PTRoute objects.
- (id)initWithRoutes:(NSArray *)routes;

// A list of NSString objects that represents available option to pick based on filter.
- (NSArray *)regions;
- (NSArray *)lines;

// The concluded stopGroup that surivive through all three filters.
- (PTRoute *)route;
- (PTRoute *)routeWithRegion:(NSString *)region line:(NSString *)line;

- (void)filterByRegion:(NSString *)region;
- (void)filterByLine:(NSString *)line;

@end
