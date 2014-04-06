//
//  PTStore.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 4/6/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTStore.h"
#import "PTStop.h"

@interface PTStore ()

@property (nonatomic, strong) NSMutableDictionary *stopsMap;

@end

@implementation PTStore

- (instancetype)init
{
  if (self = [super init]) {
    _stopsMap = [[NSMutableDictionary alloc] init];
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
  return [self.stopsMap objectForKey:identifier];
}

- (void)saveStop:(PTStop *)stop
{
  [self.stopsMap setObject:stop forKey:stop.identifier];
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
