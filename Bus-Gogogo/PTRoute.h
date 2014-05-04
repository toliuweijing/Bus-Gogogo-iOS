//
//  PTRoute.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 5/3/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "OBADataModel.h"

@interface PTRoute : NSObject <NSCopying>

- (instancetype)initWithOBACounterPart:(OBARoute *)oba;

- (NSString *)identifier; 

- (NSString *)regionPrefix; // i.e. B in B9

- (NSString *)number; // i.e. X in X27

@end
