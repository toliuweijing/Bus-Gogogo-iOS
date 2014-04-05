//
//  PTRoute.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 4/5/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTStopGroup.h"
#import "OBADataModel.h"
#import "PTBase.h"

@implementation PTStopGroup

+ (PTStopGroup *)stopGroupFromOBACounterPart:(OBAStopGroup *)oba
{
  PTStopGroup *stopGroup = [[PTStopGroup alloc] init];
  stopGroup.name = oba.Name.Name;
  stopGroup.stopIDs = oba.StopIds;
  stopGroup.polylinePoints = decodePolyLines(oba.Polylines);
  return stopGroup;
}

@end
