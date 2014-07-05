//
//  PTDashboardRoutePickerView.m
//  Bus-Gogogo
//
//  Created by Developer on 6/15/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTDashboardRoutePickerView.h"
#import "PTRoute.h"

@interface PTDashboardRoutePickerView ()
{
  PTRoute *_route;
  int _direction;
  IBOutlet UILabel *_routeTextLabel;
  IBOutlet UILabel *_directionTextLabel;
  IBOutlet UILabel *_chooseLabel;
  IBOutlet UIActivityIndicatorView *_indicator;
}

@end

@implementation PTDashboardRoutePickerView

- (void)flipDirection
{
  _direction = _direction == 1 ? 0 : 1;
  _directionTextLabel.text = [self _directionText];
}

- (void)setRoute:(PTRoute *)route
{
  assert(route);
  
  _route = route;
  _routeTextLabel.text = route.shortName;
  _directionTextLabel.text = [self _directionText];
  
  self.emptyRoutePicker.hidden = YES;
}

- (NSString *)_directionText
{
  NSArray *components = [_route.longName componentsSeparatedByString:@" - "];
  assert(components.count == 2);
  if (_direction == 1) {
    components = [[components reverseObjectEnumerator] allObjects];
  }
  NSString *text = [components componentsJoinedByString:@" to "];
  return text;
}

- (int)direction
{
  return _direction;
}

- (void)setLoadingIndicator:(BOOL)enable;
{
  if (enable) {
    [_indicator startAnimating];
    _indicator.hidden = NO;
    _chooseLabel.hidden = YES;
  } else {
    [_indicator stopAnimating];
    _indicator.hidden = YES;
    _chooseLabel.hidden = NO;
  }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
