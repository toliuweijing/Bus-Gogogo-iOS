//
//  PTStore.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 4/6/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OBADataModel.h"

@class PTStop;
@class PTRoute;

/**
 A typical store in MVCS pattern. It serves a centralized store for saving and retriving PT-models.
 */
@interface PTStore : NSObject

/**
 PTStore starts downloading all PTRoute objects at app launch.
 This property is used to observe when routes are available 
 */
@property (nonatomic, assign, readonly) BOOL allRoutesLoaded;

+ (PTStore *)sharedStore;

- (NSArray *)routes;
- (PTRoute *)routeForKey:(NSString *)routeIdentifier;


- (void)populateWithOBAResponse:(OBAResponse *)obaResponse;

- (PTStop *)stopWithIdentifier:(NSString *)identifier;
- (void)saveStop:(PTStop *)stop;

@end
