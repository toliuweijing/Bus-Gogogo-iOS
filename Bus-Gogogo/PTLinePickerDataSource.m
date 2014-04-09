//
//  PTLinePickerDataSource.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 3/22/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTLinePickerDataSource.h"

#import "PTLine.h"
#import "PTStop.h"
#import "PTStopsForRouteRequest.h"

@interface PTLinePickerDataSource ()

@end

@implementation PTLinePickerDataSource

- (instancetype)init
{
  if (self = [super init]) {
    _routeIdentifiers = [PTLinePickerDataSource routeIdentifiers];
  }
  return self;
}

- (void)dealloc
{
  
}

+ (NSArray *)routeIdentifiers
{
  return @[kRouteIdentifierB9,
           kRouteIdentifierX27];
}

- (NSString *)routeIdentifierAtIndexPath:(NSIndexPath *)indexPath
{
  // We only have 1 section.
  assert(indexPath.section == 0);
  assert(indexPath.row < self.routeIdentifiers.count);
  
  return [self.routeIdentifiers objectAtIndex:indexPath.row];
}

@end
