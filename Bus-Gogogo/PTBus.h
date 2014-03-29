//
//  PTBus.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 3/29/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface PTBus : NSObject

@property (nonatomic, strong) NSString *identifier;

@property (nonatomic, strong) CLLocation *location;

@end
