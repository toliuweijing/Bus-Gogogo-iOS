//
//  PTReminderManager.h
//  Bus-Gogogo
//
//  Created by Developer on 6/15/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PTStop;
@class PTRoute;
@interface PTReminderManager : NSObject

- (id)initWithStop:(PTStop *)stop
             route:(PTRoute *)route
         direction:(int)direction
         stopsAway:(int)stopsAway;

- (void)cancel;

@end
