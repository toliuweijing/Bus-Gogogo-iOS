//
//  PTStopDetailDownloader.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 3/23/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PTStop;

typedef void(^stop_detail_downloader_success_block)(NSArray *locations);
typedef void(^stop_detail_downloader_failure_block)(NSError *error);

@interface PTStopDetailDownloader : NSObject

- (instancetype)initWithStop:(PTStop *)stop;

- (void)downloadWithSuccessBlock:(stop_detail_downloader_success_block)successBlock
                    failureBlock:(stop_detail_downloader_failure_block)failureBlock;
@end
