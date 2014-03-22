//
//  PTLine.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 3/22/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PTLine : NSObject

// full name of bus line, i.e. X27.
@property (nonatomic, copy, readonly) NSString *identifier;

// prefix of bus line, i.e. X for line X27.
@property (nonatomic, copy, readonly) NSString *prefix;

// number of bus line, i.e. 27 for line X27.
@property (nonatomic, assign, readonly) NSInteger *number;

@end
