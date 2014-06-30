//
//  PTStop.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 3/22/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTStop.h"
#import <CoreLocation/CoreLocation.h>

@interface PTStop ()

@property (nonatomic, copy, readwrite) NSString *identifier;

@property (nonatomic, strong, readwrite) CLLocation *location;

@property (nonatomic, strong) OBAStop *obaStop;

@end

@implementation PTStop

- (instancetype)initWithOBAStop:(OBAStop *)obaStop
{
  if (self = [super init]) {
    _obaStop = obaStop;
  }
  return self;
}

- (NSString *)name
{
  return self.obaStop.Name;
}

- (NSString *)identifier
{
  return self.obaStop.Id;
}

@end
