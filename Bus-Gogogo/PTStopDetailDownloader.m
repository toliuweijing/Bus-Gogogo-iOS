//
//  PTStopDetailDownloader.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 3/23/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTStopDetailDownloader.h"
#import "PTStopMonitoringRequest.h"
#import <CoreLocation/CoreLocation.h>
#import "PTDataModels.h"
@interface PTStopDetailDownloader () <NSURLConnectionDelegate>

@property (nonatomic, strong) NSURLSession *session;

@property (nonatomic, strong) PTStop *stop;

@end

@implementation PTStopDetailDownloader

- (instancetype)initWithStop:(PTStop *)stop;
{
  if (self = [super init]) {
    _stop = stop;
    
    // init session
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    _session = [NSURLSession sessionWithConfiguration:config];
  }
  return self;
}

- (void)downloadWithCompletionHandler:(stop_detail_downloader_completion_handler)completionHandler
{
  [[self.session dataTaskWithRequest:[PTStopMonitoringRequest sampleRequest] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    MTAResponse *mta = [[MTAResponse alloc] initWithDictionary:json];
    dispatch_async(dispatch_get_main_queue(), ^{
//      successBlock(locations);
    });
  }] resume];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse {
  return nil;
}

@end
