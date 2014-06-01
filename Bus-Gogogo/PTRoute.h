//
//  PTRoute.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 5/3/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "OBADataModel.h"
#import "PTRouteProtocol.h"

@interface PTRoute : NSObject <NSCopying, PTRouteProtocol>

- (instancetype)initWithOBACounterPart:(OBARoute *)oba;

@end
