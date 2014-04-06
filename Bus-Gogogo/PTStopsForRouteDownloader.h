//
//  PTStopsForRouteDownloader.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 4/4/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTStopGroup.h"

@class PTStopsForRouteDownloader;

@protocol PTStopsForRouteDownloaderDelegate

- (void)downloader:(PTStopsForRouteDownloader *)downloader
   didReceiveStopGroups:(NSArray *)stopGroups;

- (void)downloader:(PTStopsForRouteDownloader *)downloader
   didReceiveError:(NSError *)error;

@end

@interface PTStopsForRouteDownloader : NSObject

@property (nonatomic, weak) id<PTStopsForRouteDownloaderDelegate> delegate;

- (void)startDownload;

@end
