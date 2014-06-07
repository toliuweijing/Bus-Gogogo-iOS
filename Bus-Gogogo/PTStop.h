//
//  PTStop.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 3/22/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "OBADataModel.h"
#import "PTStopProtocol.h"

@interface PTStop : NSObject <PTStopProtocol>

- (instancetype)initWithOBAStop:(OBAStop *)obaStop;

@end
