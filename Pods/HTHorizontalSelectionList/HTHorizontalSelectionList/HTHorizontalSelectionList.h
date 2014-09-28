//
//  HTHorizontalSelectionList.h
//  Hightower
//
//  Created by Erik Ackermann on 7/31/14.
//  Copyright (c) 2014 Hightower Inc. All rights reserved.
//

@import UIKit;

@protocol HTHorizontalSelectionListDataSource;
@protocol HTHorizontalSelectionListDelegate;

@interface HTHorizontalSelectionList : UIView

@property (nonatomic) NSInteger selectedButtonIndex;

@property (nonatomic, weak) id<HTHorizontalSelectionListDataSource> dataSource;
@property (nonatomic, weak) id<HTHorizontalSelectionListDelegate> delegate;

@property (nonatomic, strong) UIColor *selectionIndicatorColor;
@property (nonatomic, strong) UIColor *bottomTrimColor;

- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state;

@end

@protocol HTHorizontalSelectionListDataSource <NSObject>

- (NSInteger)numberOfItemsInSelectionList:(HTHorizontalSelectionList *)selectionList;
- (NSString *)selectionList:(HTHorizontalSelectionList *)selectionList titleForItemWithIndex:(NSInteger)index;

@end

@protocol HTHorizontalSelectionListDelegate <NSObject>

- (void)selectionList:(HTHorizontalSelectionList *)selectionList didSelectButtonWithIndex:(NSInteger)index;

@end
