//
//  PTRouteStore.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 5/26/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

@class PTRoute;

/**
 This is a centralized store that syncs down and serve PTRouteObjects.
 */
@protocol PTRouteStore <NSObject>

+ (id<PTRouteStore>)sharedStore;

/**
 PTStore starts downloading all PTRoute objects at app launch.
 This method is uesd to retrieve all PTRoute objects when it's loaded.
 */
- (void)retrieveRoutes:(void (^)(NSArray *routes))callback;

@end

@interface PTRouteStore : NSObject <PTRouteStore>

@end
