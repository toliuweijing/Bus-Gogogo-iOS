//
//  PTDownloadTask.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 6/8/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

@protocol PTDownloadRequester

- (NSURLRequest *)request;

- (id)parseData:(NSData *)data;

@end

typedef void(^download_task_callback_t)(id result, NSError *error);

@interface PTDownloadTask : NSObject

// Both this method and callback are main-thread only.
+ (PTDownloadTask *)scheduledTaskWithRequester:(id<PTDownloadRequester>)requester
                                      callback:(download_task_callback_t)callback;

@end
