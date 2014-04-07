//
//  PTLinePickerDataSource.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 3/22/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PTLine;

@interface PTLinePickerDataSource : NSObject

@property (nonatomic, strong, readonly) NSArray *routeIdentifiers;

- (NSString *)routeIdentifierAtIndexPath:(NSIndexPath *)indexPath;

@end
