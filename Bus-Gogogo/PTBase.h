//
//  PTBase.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 4/5/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

@class OBAPolyline;

NSMutableArray *decodePolyLine(OBAPolyline *polyline);
NSMutableArray *decodePolyLines(NSArray *polylines);
NSMutableArray *decodePolyLineStr(NSString *encodedStr);
