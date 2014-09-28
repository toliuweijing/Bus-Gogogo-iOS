//
//  PTRoutesForLocationRequester.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 9/28/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTDownloadTask.h"
#import <CoreLocation/CoreLocation.h>

@interface PTStopsForLocationRequester : NSObject <PTDownloadRequester>

- (instancetype)initWithLocation:(CLLocation *)location;

@end
