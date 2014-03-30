//
//  PTStopDetailDataSource.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 3/30/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PTStopDetailTableViewCell;
@class PTStopDetailDataSource;
@class PTMonitoredVehicleJourney;

extern NSString *const kCellIdentifier;

@protocol PTStopDetailDataSourceDelegate <NSObject>

- (void)dataSource:(PTStopDetailDataSource *)dataSource
     configureCell:(UITableViewCell *)cell
          withItem:(PTMonitoredVehicleJourney *)item;

@end

@interface PTStopDetailDataSource : NSObject <UITableViewDataSource>

@property (nonatomic, weak) id<PTStopDetailDataSourceDelegate> delegate;

@property (nonatomic, strong) NSArray *vehicleJourneys;

- (PTMonitoredVehicleJourney *)itemAtIndexPath:(NSIndexPath *)indexPath;

@end

