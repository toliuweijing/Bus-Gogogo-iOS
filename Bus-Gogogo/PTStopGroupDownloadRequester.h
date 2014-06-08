//
//  PTStopGroupDownloadRequester.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 6/8/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTDownloadTask.h"

@interface PTStopGroupDownloadRequester : NSObject <PTDownloadRequester>

- (instancetype)initWithRouteId:(NSString *)routeId;

@end
