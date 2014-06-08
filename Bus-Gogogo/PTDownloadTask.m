//
//  PTDownloadTask.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 6/8/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTDownloadTask.h"

@interface PTDownloadTask ()
{
  id<PTDownloadRequester> _requester;
  download_task_callback_t _callback;
  NSURLSession *_session;
}

@end

@implementation PTDownloadTask

+ (PTDownloadTask *)scheduledTaskWithRequester:(id<PTDownloadRequester>)requester
                                      callback:(download_task_callback_t)callback
{
  PTDownloadTask *task =
  [[PTDownloadTask alloc]
   initWithRequester:requester
   callback:callback];
  
  [task _start];
  return task;
}

- (instancetype)initWithRequester:(id<PTDownloadRequester>)requester
                         callback:(download_task_callback_t)callback
{
  if (self = [super init]) {
    _requester = requester;
    _callback = callback;
  }
  return self;
}

- (void)_start
{
  NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
  config.requestCachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
  _session = [NSURLSession sessionWithConfiguration:config];
  
  [[_session
   dataTaskWithRequest:[_requester request]
   completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
     id result;
     if (error == nil) {
       result = [_requester parseData:data];
     }
     dispatch_async(dispatch_get_main_queue(), ^{
       _callback(result, error);
     });
   }] resume];
}

@end
