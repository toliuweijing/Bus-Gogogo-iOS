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

- (NSString *)regionPrefix
{
  assert(_oba.ShortName.length > 0);
  NSRange range = [_oba.ShortName rangeOfCharacterFromSet:[NSCharacterSet letterCharacterSet]];
  for (int i = range.location + 1; i < _oba.ShortName.length ; ++i) {
    if ([[NSCharacterSet letterCharacterSet] characterIsMember:[_oba.ShortName characterAtIndex:i]]) {
      ++range.length;
    } else {
      break;
    }
  }
  NSString *prefix = [_oba.ShortName substringWithRange:range];
  return prefix;
}

- (NSString *)number
{
  assert(_oba.ShortName.length > 0);
  NSRange range = [_oba.ShortName rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]];
  for (int i = range.location + 1 ; i < _oba.ShortName.length ; ++i) {
    if ([[NSCharacterSet decimalDigitCharacterSet] characterIsMember:[_oba.ShortName characterAtIndex:i]]) {
      ++range.length;
    } else {
      break;
    }
  }
  NSString *number = [_oba.ShortName substringWithRange:range];
  return number;
}

- (id)copyWithZone:(NSZone *)zone
{
  id copy = [[[self class] alloc] initWithOBACounterPart:_oba];
  
  return copy;
}

@end
