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

@interface PTRouteDataHelper : NSObject

- (instancetype)initWithRoutes:(NSArray *)routes;
- (NSArray *)regionPrefixes;
- (NSArray *)routesForRegionPrefix:(NSString *)regionPrefix;

@end

@implementation PTRouteDataHelper
{
  NSArray *_regionPrefixes;
  NSDictionary *_routesForRegionPrefixMap; // i.e. 'B' -> [B9, B11]
}

- (instancetype)initWithRoutes:(NSArray *)routes
{
  if (self = [super init]) {
    _routesForRegionPrefixMap = [self _routesForRegionPrefixMapWithRoutes:routes];
    _regionPrefixes = [_routesForRegionPrefixMap.allKeys sortedArrayUsingSelector:@selector(compare:)];
  }
  return self;
}

- (NSArray *)regionPrefixes
{
  return _regionPrefixes;
}

- (NSArray *)routesForRegionPrefix:(NSString *)regionPrefix
{
  assert(_routesForRegionPrefixMap[regionPrefix]);
  return _routesForRegionPrefixMap[regionPrefix];
}

- (NSDictionary *)_routesForRegionPrefixMapWithRoutes:(NSArray *)routes
{
  NSMutableDictionary *mapper = [[NSMutableDictionary alloc] init];
  
  // a mapper from regionPrefix to an array of routes.
  for (PTRoute *route in routes) {
    assert([route isKindOfClass:[PTRoute class]]);
    
    if (mapper[route.regionPrefix] == nil) {
      [mapper setObject:[NSMutableArray new] forKey:route.regionPrefix];
    }
    
    [mapper[route.regionPrefix] addObject:route];
  }
  
  for (NSString *key in mapper.allKeys) {
    [mapper[key] sortUsingComparator:^NSComparisonResult(PTRoute *obj1, PTRoute *obj2) {
      return [obj1.number compare:obj2.number];
    }];
  }
  return mapper;
}

@end

@interface PTStopGroupPickerViewController () <UIPickerViewDataSource, UIPickerViewDelegate>
{
  UIPickerView *_pickerView;
  NSMutableArray *_selectedRows; // i.e. [1, 2, 3]
  PTRouteDataHelper *_dataHelper;
}

@property (nonatomic, strong) NSArray *routes;

@end

@implementation PTStopGroupPickerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // observe on -[PTStore routes]
    _selectedRows = [@[@(0), @(0), @(0)] mutableCopy];
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
  _dataHelper = [[PTRouteDataHelper alloc] initWithRoutes:routes];
  
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
  
  if (component == 0) {
    return [_dataHelper regionPrefixes].count;
  } else if (component == 1) {
    NSString *currentRegion = [self _selectedRegionPrefix];
    return [_dataHelper routesForRegionPrefix:currentRegion].count;
  } else if (component == 2) {
    return 2;
  } else {
    assert(NO);
    return 0;
  }
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
    return [[_dataHelper regionPrefixes] objectAtIndex:row];
  } else if (component == 1) {
    NSString *prefix = [self _selectedRegionPrefix];
    NSArray *routes = [_dataHelper routesForRegionPrefix:prefix];
    PTRoute *route = [routes objectAtIndex:row];
    return route.number;
  } else if(component == 2) {
    return [@(row) stringValue];
  }
  assert(NO);
  return nil;
}

- (NSString *)_selectedRegionPrefix
{
  int row = [[_selectedRows objectAtIndex:0] integerValue];
  return [[_dataHelper regionPrefixes] objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component
{
  // update current selection
  _selectedRows[component] = @(row);
  
  // reload next component
  if (component < 2) {
    [pickerView reloadComponent: component+1];
  }
}

@end
