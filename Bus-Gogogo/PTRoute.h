//
//  PTRoute.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 5/3/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "OBADataModel.h"

@interface PTRoute : NSObject

- (instancetype)initWithOBACounterPart:(OBARoute *)oba;

- (NSString *)identifier; 

- (NSString *)prefix; // i.e. B in B9

- (NSString *)number; // i.e. X in X27

@end
