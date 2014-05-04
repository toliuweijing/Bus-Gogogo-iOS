//
//  PTStore.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 4/6/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTStore.h"
#import "PTStop.h"
#import "PTRoute.h"
#import "PTAllRoutesDownloadTask.h"

@interface PTStore ()
{
  NSMutableDictionary *_stopsMap; // stopID -> PTStop
  NSMutableDictionary *_routesMap; // routeID -> PTRoute
  PTAllRoutesDownloadTask *_task;
}

@property (nonatomic, assign) BOOL allRoutesLoaded;

@end

@implementation PTStore

- (instancetype)init
{
  if (self = [super init]) {
    _stopsMap = [[NSMutableDictionary alloc] init];
    _routesMap = [[NSMutableDictionary alloc] init];
    
    [self _syncAllRoutes];
  }
  return self;
}

- (void)_syncAllRoutes
{
  _task = [PTAllRoutesDownloadTask scheduledTaskWithCompletionHandler:^(NSArray *routes, NSError *error) {
    for (PTRoute *route in routes) {
      assert(route.identifier);
      [_routesMap setObject:route forKey:route.identifier];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
      self.allRoutesLoaded = YES;
    });
  }];
}

+ (PTStore *)sharedStore
{
  static PTStore *store;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    store = [[PTStore alloc] init];
  });
  return store;
}

- (PTStop *)stopWithIdentifier:(NSString *)identifier
{
  assert(identifier);
  return [_stopsMap objectForKey:identifier];
}

- (void)saveStop:(PTStop *)stop
{
  [_stopsMap setObject:stop forKey:stop.identifier];
}

- (void)populateWithOBAResponse:(OBAResponse *)oba
{
  // populate PTStops
  for (OBAStop *obaStop in oba.Data.Stops) {
    PTStop *ptStop = [[PTStop alloc] initWithOBAStop:obaStop];
    [self saveStop:ptStop];
  }
}

- (NSArray *)routes
{
  return [_routesMap allValues];
}

- (PTRoute *)routeForKey:(NSString *)routeIdentifier
{
  return [_routesMap objectForKey:routeIdentifier];
}

@end
