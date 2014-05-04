//
//  PTRoute.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 5/3/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTRoute.h"

@interface PTRoute ()
{
  OBARoute *_oba;
}

@end

@implementation PTRoute

- (instancetype)initWithOBACounterPart:(OBARoute *)oba
{
  if (self = [super init]) {
    _oba = oba;
  }
  return self;
}

- (NSString *)identifier
{
  return _oba.Id;
}

- (NSString *)prefix
{
  assert(_oba.ShortName.length > 0);
  return [_oba.ShortName substringToIndex:1];
}

- (NSString *)number
{
  assert(_oba.ShortName.length > 0);
  return [_oba.ShortName substringFromIndex:1];
}

@end
