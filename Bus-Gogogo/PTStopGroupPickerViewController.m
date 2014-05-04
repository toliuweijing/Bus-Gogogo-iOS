//
//  PTStopGroupPickerViewController.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 5/4/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTStopGroupPickerViewController.h"
#import "PTStore.h"
#import "PTRoute.h"

const CGFloat kMaximumViewHeight = 216.0;

@interface PTStopGroupPickerViewController () <UIPickerViewDataSource, UIPickerViewDelegate>
{
  UIPickerView *_pickerView;
}

@property (nonatomic, strong) NSArray *routes;

@end

@implementation PTStopGroupPickerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // observe on -[PTStore routes]
    [self _observeOnStoreAllRoutesProperty];
  }
  return self;
}
     
- (void)_observeOnStoreAllRoutesProperty
{
  [[PTStore sharedStore] addObserver:self
                          forKeyPath:@"allRoutesLoaded"
                             options:NSKeyValueObservingOptionNew
                             context:NULL];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
  if (object == [PTStore sharedStore] && [keyPath isEqualToString:@"allRoutesLoaded"]) {
    self.routes = [[PTStore sharedStore] routes];
  }
}

- (void)setRoutes:(NSArray *)routes
{
  _routes = routes;
  [_pickerView reloadAllComponents];
}

- (void)loadView
{
  _pickerView = [UIPickerView new];
  _pickerView.delegate = self;
  
  self.view = _pickerView;
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (BOOL)_isLoadingAllRoutes
{
  return self.routes == nil;
}

#pragma mark - PTStopGroupPickerViewDataSource

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
  if ([self _isLoadingAllRoutes]) {
    return 1;
  }
  
  return 3;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
  if ([self _isLoadingAllRoutes]) {
    return 1;
  }
  return 3;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
  assert(component < 3);
  
  if ([self _isLoadingAllRoutes]) {
    return @"loading";
  }
  
  if (component == 0) {
    return [@[@"A", @"B", @"X"] objectAtIndex:row];
  } else {
    return [@(row) stringValue];
  }
}

@end
