//
//  PTBase.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 4/5/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

@class OBAPolyline;
@class CLLocation;


@interface PTBase : NSObject

+ (NSMutableArray *)decodePolyLine:(OBAPolyline *)polyline;
+ (NSMutableArray *)decodePolyLines:(NSArray *)polylines;
+ (NSMutableArray *)decodePolyLineStr:(NSString *)encodedStr;

+ (NSString *)shuttlePictureImageName;
+ (UIFont *)font;
+ (UIFont *)fontWithSize:(CGFloat)size;
+ (NSString *)distanceStringBetweenA:(CLLocation *)a b:(CLLocation *)b;

+ (UIColor *)colorWithHex:(NSString *)string;
// Punch = #
+ (UIColor *)colorWithHexWithPunch:(NSString *)string;
@end
