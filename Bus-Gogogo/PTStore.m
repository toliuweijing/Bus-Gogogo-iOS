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
  
  // PTRouteStore callbacks
  NSMutableArray *_routeStoreCallbacks;
}

@property (nonatomic, assign) BOOL allRoutesLoaded;

@end

@implementation PTStore

- (instancetype)init
{
  if (self = [super init]) {
    _stopsMap = [[NSMutableDictionary alloc] init];
    _routesMap = [[NSMutableDictionary alloc] init];
    _routeStoreCallbacks = [[NSMutableArray alloc] init];
  }
  return self;
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


@end
