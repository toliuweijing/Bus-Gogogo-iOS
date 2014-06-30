//
//  PTRouteStore.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 5/26/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTRouteStore.h"
#import "PTRoute.h"

#import "PTDownloadTask.h"
#import "PTAllRoutesDownloadRequester.h"

@implementation PTRouteStore
{
  // PTRouteStore sync down PTRoute objects at access time. This
  // variable is used to indicate whether the process is finished.
  NSArray *_routes;
  
  // A mapper indexed by PTRoute ids.
  NSMutableDictionary *_routesMap;
  
  // A download task for fetching PTRoute objects.
  PTDownloadTask *_task;
  
  // Queued listeners
  NSMutableArray *_listeners;
}

+ (id<PTRouteStore>)sharedStore
{
  static PTRouteStore *store;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    store = [[PTRouteStore alloc] init];
  });
  return store;
}

- (id)init
{
  if (self = [super init]) {
    _routesMap = [NSMutableDictionary new];
    _listeners = [NSMutableArray new];
    [self _syncAllRoutes];
  }
  return self;
}

- (BOOL)_loaded
{
  return _routes != nil;
}

- (void)_configureWithRoutes:(NSArray *)routes
{
  _routes = [routes copy];
  for (PTRoute *route in routes) {
    assert(route.identifier);
    [_routesMap setObject:route forKey:route.identifier];
  }
}

- (void)_syncAllRoutes
{
  _task =
  [PTDownloadTask
   scheduledTaskWithRequester:[[PTAllRoutesDownloadRequester alloc] init]
   callback:^(NSArray *routes, NSError *error) {
     assert(error == nil);
     [self _configureWithRoutes:routes];
     dispatch_async(dispatch_get_main_queue(), ^{
       [self _maybeNotifyListeners];
     });
   }];
}

#pragma mark - PTRouteStore

- (void)retrieveRoutes:(void (^)(NSArray *))listener
{
  [_listeners addObject:listener];
  [self _maybeNotifyListeners];
}

- (void)_maybeNotifyListeners
{
  if ([self _loaded]) {
    for (void (^listener)(NSArray *) in _listeners) {
      listener(_routes);
    }
    [_listeners removeAllObjects];
  }
}

@end
