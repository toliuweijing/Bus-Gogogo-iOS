//
//  PTBase.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 4/5/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "OBADataModel.h"
#import "PTBase.h"

@implementation PTBase

+ (NSMutableArray *)decodePolyLines:(NSArray *)polylines
{
  NSMutableArray *collection = [[NSMutableArray alloc] init];
  for (OBAPolyline *polyline in polylines) {
    assert([polyline isKindOfClass:[OBAPolyline class]]);
    [collection addObjectsFromArray:[self decodePolyLine:polyline]];
  }
  return collection;
}

+ (NSMutableArray *)decodePolyLine:(OBAPolyline *)polyline
{
  return [self decodePolyLineStr:polyline.Points];
}

+ (NSMutableArray *)decodePolyLineStr:(NSString *)encodedStr
{
//  NSMutableString *encoded = [[NSMutableString alloc] initWithCapacity:[encodedStr length]];
  NSMutableString *encoded = [[NSMutableString alloc] initWithString:@""];
  [encoded appendString:encodedStr];
  [encoded replaceOccurrencesOfString:@"\\\\" withString:@"\\"
                              options:NSLiteralSearch
                                range:NSMakeRange(0, [encoded length])];
  NSInteger len = [encoded length];
  NSInteger index = 0;
  NSMutableArray *array = [[NSMutableArray alloc] init];
  NSInteger lat=0;
  NSInteger lng=0;
  while (index < len) {
    NSInteger b;
    NSInteger shift = 0;
    NSInteger result = 0;
    do {
      b = [encoded characterAtIndex:index++] - 63;
      result |= (b & 0x1f) << shift;
      shift += 5;
    } while (b >= 0x20);
    NSInteger dlat = ((result & 1) ? ~(result >> 1) : (result >> 1));
    lat += dlat;
    shift = 0;
    result = 0;
    do {
      b = [encoded characterAtIndex:index++] - 63;
      result |= (b & 0x1f) << shift;
      shift += 5;
    } while (b >= 0x20);
    NSInteger dlng = ((result & 1) ? ~(result >> 1) : (result >> 1));
    lng += dlng;
    NSNumber *latitude = [[NSNumber alloc] initWithFloat:lat * 1e-5];
    NSNumber *longitude = [[NSNumber alloc] initWithFloat:lng * 1e-5];
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:[latitude floatValue] longitude:[longitude floatValue]];
    [array addObject:location];
  }
  
  return array;
}

+ (NSString *)shuttlePictureImageName
{
  static NSString *const kShuttlePictureImageName = @"Shuttle-Picture.png";
  return kShuttlePictureImageName;
}

+ (UIFont *)font
{
  return [self fontWithSize:12];
}

+ (UIFont *)fontWithSize:(CGFloat)size
{
  return [UIFont fontWithName:@"Avenir" size:size];
}

@end

