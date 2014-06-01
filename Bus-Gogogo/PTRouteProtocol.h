//
//  PTRouteProtocol.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 6/1/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PTRouteProtocol <NSObject>

- (NSString *)identifier; 

- (NSString *)regionPrefix; // i.e. B in B9

- (NSString *)number; // i.e. X in X27

@end
