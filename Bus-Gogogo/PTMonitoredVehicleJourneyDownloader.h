//
//  PTMonitoredVehicleJourneyDownloader.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 4/6/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTMonitoredVehicleJourney.h"

@class PTMonitoredVehicleJourneyDownloader;

@protocol PTMonitoredVehicleJourneyDownloaderDelegate

- (void)downloader:(PTMonitoredVehicleJourneyDownloader *)downloader
didReceiveVehicleJourneys:(NSArray *)vehicleJourneys;

@end

@interface PTMonitoredVehicleJourneyDownloader : NSObject

@property (nonatomic, weak) id<PTMonitoredVehicleJourneyDownloaderDelegate> delegate;

- (instancetype)initWithRouteIdentifier:(NSString *)routeID;

- (void)startDownload;

@end
