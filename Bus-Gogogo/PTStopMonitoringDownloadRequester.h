//
//  PTStopMonitoringDownloadRequester.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 6/14/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTDownloadTask.h"

@interface PTStopMonitoringDownloadRequester : NSObject <PTDownloadRequester>

- (instancetype)initWithStopId:(NSString *)stopId
                       routeId:(NSString *)routeId
                     direction:(int)direction;

+ (instancetype)sampleB9EightAv;
+ (instancetype)sampleB9ShoreRd;

@end
