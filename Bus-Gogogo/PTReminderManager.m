//
//  PTReminderManager.m
//  Bus-Gogogo
//
//  Created by Developer on 6/15/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTReminderManager.h"
#import "PTStopMonitoringDownloadRequester.h"
#import "PTStop.h"
#import "PTRoute.h"
#import "PTMonitoredVehicleJourney.h"
#import <AVFoundation/AVAudioPlayer.h>
#import <AudioToolbox/AudioToolbox.h>

@interface PTReminderManager () <UIAlertViewDelegate>
{
  NSTimer *_timer;
  PTDownloadTask *_task;
  PTStop *_stop;
  PTRoute *_route;
  int _stopsAway;
  int _direction;
}

@end

@implementation PTReminderManager

- (id)initWithStop:(PTStop *)stop
             route:(PTRoute *)route
         direction:(int)direction
         stopsAway:(int)stopsAway
{
  if (self = [super init]) {
    _stop = stop;
    _route = route;
    _direction = direction;
    _stopsAway = stopsAway;
    [self onTick:nil];
    _timer = [NSTimer
              scheduledTimerWithTimeInterval:30
              target:self
              selector:@selector(onTick:)
              userInfo:nil
              repeats:YES];
  }
  return self;
}

- (void)cancel
{
  if (_timer == nil) {
//  assert(_timer);
    NSLog(@"%s", __func__);
  }
  [_timer invalidate];
  _timer = nil;
}

- (void)onTick:(NSTimer *)timer
{
  PTStopMonitoringDownloadRequester *requester =
  [[PTStopMonitoringDownloadRequester alloc]
   initWithStopId:_stop.identifier
   routeId:_route.identifier
   direction:_direction];
  
  _task = [PTDownloadTask
           scheduledTaskWithRequester:requester
           callback:^(NSArray *journeys, NSError *error) {
             for (PTMonitoredVehicleJourney *j in journeys) {
               NSLog(@"stopsFromCall = %d", j.stopsFromCall);
               if (j.stopsFromCall <= _stopsAway) {
                 
                 [self _playSound];
                 UIAlertView *alert =
                 [[UIAlertView alloc] initWithTitle:@"Reminder"
                                            message:[NSString stringWithFormat:
                                                     @"A %@ Bus is ARRIVING %@", _route.shortName, _stop.name]
                                           delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
                 [alert show];

                 break;
               }
             }
           }];
}

- (void)_playSound
{
  AudioServicesPlaySystemSound(1011);
  AudioServicesPlaySystemSound(1007);
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
  [self cancel];
}

@end
