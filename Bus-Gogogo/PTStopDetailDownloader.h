//
//  PTStopDetailDownloader.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 3/23/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PTStop;

typedef void(^stop_detail_downloader_completion_handler)(NSArray *locations, NSError *error);

@interface PTStopDetailDownloader : NSObject

- (instancetype)initWithStop:(PTStop *)stop;

- (void)downloadWithCompletionHandler:(stop_detail_downloader_completion_handler)completionHandler;

@end
