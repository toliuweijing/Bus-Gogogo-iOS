//
//  HTHorizontalSelectionList.m
//  Hightower
//
//  Created by Erik Ackermann on 7/31/14.
//  Copyright (c) 2014 Hightower Inc. All rights reserved.
//

#import "HTHorizontalSelectionList.h"
#import "HTHorizontalSelectionListScrollView.h"

@interface HTHorizontalSelectionList ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *buttons;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIView *selectionIndicator;

@property (nonatomic, strong) NSLayoutConstraint *leftSelectionIndicatorConstraint, *rightSelectionIndicatorConstraint;

@property (nonatomic, strong) UIView *bottomTrim;

@property (nonatomic, strong) NSMutableDictionary *buttonColorsByState;

@end

#define kHTHorizontalSelectionListHorizontalMargin 10
#define kHTHorizontalSelectionListInternalPadding 15

#define kHTHorizontalSelectionListSelectionIndicatorHeight 3

#define kHTHorizontalSelectionListTrimHeight 0.5

@implementation HTHorizontalSelectionList

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];

        _scrollView = [[HTHorizontalSelectionListScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.scrollsToTop = NO;
        _scrollView.canCancelContentTouches = YES;
        _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_scrollView];

        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_scrollView]|"
                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(_scrollView)]];

        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_scrollView]|"
                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(_scrollView)]];

        _contentView = [[UIView alloc] init];
        _contentView.translatesAutoresizingMaskIntoConstraints = NO;
        [_scrollView addSubview:_contentView];

        [self addConstraint:[NSLayoutConstraint constraintWithItem:_contentView
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeTop
                                                        multiplier:1.0
                                                          constant:0.0]];

        [self addConstraint:[NSLayoutConstraint constraintWithItem:_contentView
                                                         attribute:NSLayoutAttributeBottom
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1.0
                                                          constant:0.0]];

        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_contentView]|"
                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(_contentView)]];

        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_contentView]|"
                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(_contentView)]];

        _bottomTrim = [[UIView alloc] init];
        _bottomTrim.backgroundColor = [UIColor blackColor];
        _bottomTrim.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_bottomTrim];

        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_bottomTrim]|"
                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(_bottomTrim)]];

        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_bottomTrim(height)]|"
                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
                                                                     metrics:@{@"height" : @(kHTHorizontalSelectionListTrimHeight)}
                                                                       views:NSDictionaryOfVariableBindings(_bottomTrim)]];

        _buttons = [NSMutableArray array];

        _selectionIndicator = [[UIView alloc] init];
        _selectionIndicator.translatesAutoresizingMaskIntoConstraints = NO;
        _selectionIndicator.backgroundColor = [UIColor blackColor];

        _buttonColorsByState = [NSMutableDictionary dictionary];
        _buttonColorsByState[@(UIControlStateNormal)] = [UIColor blackColor];
    }
    return self;
}

#pragma mark - Custom Getters and Setters

- (void)setSelectionIndicatorColor:(UIColor *)selectionIndicatorColor {
    self.selectionIndicator.backgroundColor = selectionIndicatorColor;
}

- (UIColor *)selectionIndicatorColor {
    return self.selectionIndicator.backgroundColor;
}

- (void)setBottomTrimColor:(UIColor *)bottomTrimColor {
    self.bottomTrim.backgroundColor = bottomTrimColor;
}

- (UIColor *)bottomTrimColor {
    return self.bottomTrim.backgroundColor;
}

- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state {
    self.buttonColorsByState[@(state)] = color;
}

#pragma mark - Private Methods

- (void)layoutSubviews {
    for (UIButton *button in self.buttons) {
        [button removeFromSuperview];
    }

    [self.selectionIndicator removeFromSuperview];
    [self.buttons removeAllObjects];

    NSInteger totalButtons = [self.dataSource numberOfItemsInSelectionList:self];

    UIButton *previousButton;

    for (NSInteger index = 0; index < totalButtons; index++) {
        NSString *buttonTitle = [self.dataSource selectionList:self titleForItemWithIndex:index];

        UIButton *button = [self selectionListButtonWithTitle:buttonTitle];
        [self.contentView addSubview:button];

        if (previousButton) {
            [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[previousButton]-padding-[button]"
                                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
                                                                                     metrics:@{@"padding" : @(kHTHorizontalSelectionListInternalPadding)}
                                                                                       views:NSDictionaryOfVariableBindings(previousButton, button)]];
        } else {
            [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-margin-[button]"
                                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
                                                                                     metrics:@{@"margin" : @(kHTHorizontalSelectionListHorizontalMargin)}
                                                                                       views:NSDictionaryOfVariableBindings(button)]];
        }

        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:button
                                                         attribute:NSLayoutAttributeCenterY
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.contentView
                                                         attribute:NSLayoutAttributeCenterY
                                                        multiplier:1.0
                                                          constant:0.0]];

        previousButton = button;

        [self.buttons addObject:button];
    }

    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[previousButton]-margin-|"
                                                                             options:NSLayoutFormatDirectionLeadingToTrailing
                                                                             metrics:@{@"margin" : @(kHTHorizontalSelectionListHorizontalMargin)}
                                                                               views:NSDictionaryOfVariableBindings(previousButton)]];

    if (totalButtons > 0) {
        UIButton *selectedButton = self.buttons[self.selectedButtonIndex];
        selectedButton.selected = YES;

        [self.contentView addSubview:self.selectionIndicator];

        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_selectionIndicator(height)]|"
                                                                                options:NSLayoutFormatDirectionLeadingToTrailing
                                                                                 metrics:@{@"height" : @(kHTHorizontalSelectionListSelectionIndicatorHeight)}
                                                                                   views:NSDictionaryOfVariableBindings(_selectionIndicator)]];

        [self alignSelectionIndicatorWithButton:selectedButton];
    }

    [self sendSubviewToBack:self.bottomTrim];

    [super layoutSubviews];
}

- (UIButton *)selectionListButtonWithTitle:(NSString *)buttonTitle {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [button setTitle:buttonTitle.uppercaseString forState:UIControlStateNormal];

    for (NSNumber *controlState in [self.buttonColorsByState allKeys]) {
        [button setTitleColor:self.buttonColorsByState[controlState] forState:controlState.integerValue];
    }

    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [button sizeToFit];

    [button addTarget:self
               action:@selector(buttonWasTapped:)
     forControlEvents:UIControlEventTouchUpInside];

    button.translatesAutoresizingMaskIntoConstraints = NO;
    return button;
}

- (void)alignSelectionIndicatorWithButton:(UIButton *)button {
    self.leftSelectionIndicatorConstraint = [NSLayoutConstraint constraintWithItem:self.selectionIndicator
                                                                         attribute:NSLayoutAttributeLeft
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:button
                                                                         attribute:NSLayoutAttributeLeft
                                                                        multiplier:1.0
                                                                          constant:0.0];
    [self.contentView addConstraint:self.leftSelectionIndicatorConstraint];

    self.rightSelectionIndicatorConstraint = [NSLayoutConstraint constraintWithItem:self.selectionIndicator
                                                                          attribute:NSLayoutAttributeRight
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:button
                                                                          attribute:NSLayoutAttributeRight
                                                                         multiplier:1.0
                                                                           constant:0.0];
    [self.contentView addConstraint:self.rightSelectionIndicatorConstraint];
}

#pragma mark - Action Handlers

- (void)buttonWasTapped:(id)sender {
    NSInteger index = [self.buttons indexOfObject:sender];
    if (index != NSNotFound) {
        if (index == self.selectedButtonIndex) {
            return;
        }

        UIButton *oldSelectedButton = self.buttons[self.selectedButtonIndex];
        oldSelectedButton.selected = NO;
        self.selectedButtonIndex = index;

        UIButton *tappedButton = (UIButton *)sender;
        tappedButton.selected = YES;

        [self layoutIfNeeded];
        [UIView animateWithDuration:0.4
                              delay:0
             usingSpringWithDamping:0.5
              initialSpringVelocity:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             [self.contentView removeConstraint:self.leftSelectionIndicatorConstraint];
                             [self.contentView removeConstraint:self.rightSelectionIndicatorConstraint];

                             [self alignSelectionIndicatorWithButton:tappedButton];
                             [self layoutIfNeeded];
                         }
                         completion:nil];

        [self.scrollView scrollRectToVisible:CGRectInset(tappedButton.frame, -kHTHorizontalSelectionListHorizontalMargin, 0)
                                    animated:YES];

        if ([self.delegate respondsToSelector:@selector(selectionList:didSelectButtonWithIndex:)]) {
            [self.delegate selectionList:self didSelectButtonWithIndex:index];
        }
    }
}

@end
