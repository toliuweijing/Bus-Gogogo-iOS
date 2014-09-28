//
//  PTDownloadTaskTests.m
//  Bus-Gogogo
//
//  Created by Weijing Liu on 6/8/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "PTDownloadTask.h"

@interface PTDownloadTaskTests : XCTestCase <
  PTDownloadRequester
>
{
  id _mSession;
  id _mDataTask;
  id _mURLRequest;
  id _mParsedResult;
}

@end

@implementation PTDownloadTaskTests

- (void)setUp
{
  [super setUp];
  [self setUpNSURLSession];
  
  _mURLRequest = [OCMockObject mockForClass:[NSURLRequest class]];
  _mParsedResult = [OCMockObject mockForClass:[NSObject class]];
}

- (void)setUpNSURLSession
{
  _mSession = [OCMockObject mockForClass:[NSURLSession class]];
  [[[_mSession stub] andReturn:_mSession] sessionWithConfiguration:[OCMArg any]];
  
  _mDataTask = [OCMockObject mockForClass:[NSURLSessionDataTask class]];
  [[[_mSession stub]
    andDo:^(NSInvocation *invocation) {
      __unsafe_unretained void (^callback)(NSData *data, NSURLResponse *response, NSError *error);
      [invocation getArgument:&callback atIndex:3];
      [invocation setReturnValue:&_mDataTask];
      
      [PTDownloadTaskTests invokeCallback:callback withError:NO];
    }]
   dataTaskWithRequest:[OCMArg any]
   completionHandler:[OCMArg any]];
}

+ (void)invokeCallback:(void (^)(NSData *data, NSURLResponse *response, NSError *error))callback withError:(BOOL)error
{
  if (error) {
    callback([OCMockObject mockForClass:[NSData class]],
             [OCMockObject mockForClass:[NSURLResponse class]],
             [OCMockObject mockForClass:[NSError class]]);
  } else {
    callback([OCMockObject mockForClass:[NSData class]],
             [OCMockObject mockForClass:[NSURLResponse class]],
             nil);
  }
}

- (void)tearDown
{
  // Put teardown code here. This method is called after the invocation of each test method in the class.
  [super tearDown];
  
  [self verify];
}

- (NSURLRequest *)request
{
  return _mURLRequest;
}

- (void)parseData:(NSData *)data
{
  _mParsedResult = data;
}

- (void)verify
{
  [_mDataTask verify];
  [_mSession verify];
}

- (void)testTaskShouldCallParseResult
{
  // expectation
  [[_mDataTask expect] resume];
  _mParsedResult = nil;
  
  // run test
  __block BOOL callbackReceived = NO;
  [PTDownloadTask
   scheduledTaskWithRequester:self
   callback:^(id requester, NSError *error) {
     XCTAssertTrue([NSThread isMainThread],
                   @"expecting to be called on main-thread");
     XCTAssertTrue(requester == self, @"requester");
     XCTAssertNotNil(_mParsedResult, @"expecting parseResult called");
     callbackReceived = YES;
   }];
  
  [self
   runRunLoopUntilTimeout:1
   condition:^BOOL{
     return callbackReceived;
   }];
}

- (void)testTaskShouldCallbackOnMainthread
{
  // expectation
  [[_mDataTask expect] resume];
  
  // run test
  __block BOOL callbackReceived = NO;
  [PTDownloadTask
   scheduledTaskWithRequester:self
   callback:^(id requester, NSError *error) {
     XCTAssertTrue([NSThread isMainThread],
                   @"expecting to be called on main-thread");
     XCTAssertTrue(requester == self,
                   @"expecting parsed result");
     callbackReceived = YES;
   }];
  
  [self
   runRunLoopUntilTimeout:1
   condition:^BOOL{
    return callbackReceived;
   }];
}

- (void)runRunLoopUntilTimeout:(NSTimeInterval)timeout
                     condition:(BOOL (^)(void))block
{
  NSDate *loopUntil = [NSDate dateWithTimeIntervalSinceNow:timeout];
  while ([loopUntil timeIntervalSinceNow] > 0) {
    if (block()) {
      return;
    }
    [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                             beforeDate:loopUntil];
  }
  XCTFail(@"Failed to pass condition check with %lf secs", timeout);
}

@end
