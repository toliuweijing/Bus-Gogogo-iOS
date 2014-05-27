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
 Class singleton
 */
+ (PTStore *)sharedStore;

- (void)populateWithOBAResponse:(OBAResponse *)obaResponse;

- (PTStop *)stopWithIdentifier:(NSString *)identifier;
- (void)saveStop:(PTStop *)stop;

@end
