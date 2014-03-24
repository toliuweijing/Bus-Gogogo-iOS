//
//  PTStopDetailViewController.h
//  Bus-Gogogo
//
//  Created by Weijing Liu on 3/22/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PTStop;
@class PTLine;

@interface PTStopDetailViewController : UIViewController

- (instancetype)initWithStop:(PTStop *)stop;

@property (nonatomic, strong) PTLine *line;

@end
