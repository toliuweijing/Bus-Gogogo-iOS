//
//  PTRemoteReminderRequest.m
//  Bus-Gogogo
//
//  Created by Developer on 6/28/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import "PTRemoteReminderRequest.h"
#import "PTRouteProtocol.h"
#import "PTStopProtocol.h"
#import "PTAppDelegate.h"

@interface PTRemoteReminderRequest ()
{
  id<PTRouteProtocol> _route;
  id<PTStopProtocol> _stop;
  int _direction;
  int _arrivalRadar;
  NSString *_clientID;
  NSURLRequest *_urlRequest;
}

@end

@implementation PTRemoteReminderRequest

- (instancetype)initWithStop:(id<PTStopProtocol>)stop
                       route:(id<PTRouteProtocol>)route
                   direction:(int)direction
                arrivalRadar:(int)arrivalRadar
                   clientID:(NSString *)clientID
{
  if (self = [super init]) {
    _stop = stop;
    _route = route;
    _direction = direction;
    _arrivalRadar = arrivalRadar;
    _clientID = clientID;
  }
  return self;
}

- (NSURLRequest *)urlRequest
{
  if (!_urlRequest) {
    _urlRequest = [self _buildRequest];
  }
  return _urlRequest;
}

- (NSURLRequest *)_buildRequest
{
  
  NSString *format =
  @"http://ec2-54-88-127-149.compute-1.amazonaws.com:85/CreateArrivalReminder?"
  "routeid=%@&"
  "stopid=%@&"
  "direction=%d&"
  "stopaway=%d&"
  "clientid=%@&"
  "message=%@";
  
  NSString *sendingMessage = [NSString stringWithFormat:@"A %@ is arriving %@", _route.shortName, _stop.name];
  
  NSString *urlString =
  [NSString
   stringWithFormat:format,
   _route.identifier,
   _stop.identifier,
   _direction,
   _arrivalRadar,
   _clientID,
   sendingMessage];
  
  urlString = [urlString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
  
  NSURLRequest *request = [NSURLRequest requestWithURL: [NSURL URLWithString:urlString]];
  
  return request;
}

+ (PTRemoteReminderRequest *)requestWithStop:(id<PTStopProtocol>)stop
                                       route:(id<PTRouteProtocol>)route
                                   direction:(int)direction
                                arrivalRadar:(int)arrivalRadar
{
  PTAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    return [[PTRemoteReminderRequest alloc]
          initWithStop:stop
          route:route
          direction:direction
          arrivalRadar:arrivalRadar
          clientID:appDelegate.clientID];
}

@end
