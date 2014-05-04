//
//  PTAllRoutesDownloadTask.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 5/3/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

@class PTRoute;

@interface PTAllRoutesDownloadTask : NSObject

+ (PTAllRoutesDownloadTask *)scheduledTaskWithCompletionHandler:(void (^)(NSArray *routes, NSError *error))completionHandler;

@end
