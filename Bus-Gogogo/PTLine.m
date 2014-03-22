//
//  PTLine.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 3/22/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTLine.h"

#import "PTStop.h"

@interface PTLine ()

@property (nonatomic, copy, readwrite) NSString *prefix;

@property (nonatomic, copy, readwrite) NSString *number;

@property (nonatomic, strong, readwrite) NSArray *stops;

@end

@implementation PTLine

+ (PTLine *)lineForX27
{
  PTLine *line = [[PTLine alloc] init];
  
  // only one stop.
  NSArray *stops = @[[PTStop stopAtBayRidgeShoreRoad]];
  line.prefix = @"X";
  line.number = @"27";
  line.stops = stops;
  
  return line;
}

- (NSString *)identifier
{
  return [self.prefix stringByAppendingString:self.number];
}

@end
