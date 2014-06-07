//
//  PTStopGroupDownloadTask.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 6/7/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

@interface PTStopGroupDownloadTask : NSObject

typedef void (^StopGroupCallback)(NSArray *stopGroups, NSError *error);

+ (PTStopGroupDownloadTask *)scheduledTaskWithRouteId:(NSString *)routeId
                                             callback:(StopGroupCallback)callback;

@end
