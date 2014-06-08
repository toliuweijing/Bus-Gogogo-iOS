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
  id _mockDataTask;
}

@end

@implementation PTDownloadTaskTests

- (void)setUp
{
  [super setUp];
  [self setUpNSURLSession];
}

- (void)setUpNSURLSession
{
  id mockSesion = [OCMockObject mockForClass:[NSURLSession class]];
  [[[mockSesion stub] andReturn:mockSesion] sessionWithConfiguration:[OCMArg any]];
  
  _mockDataTask = [OCMockObject mockForClass:[NSURLSessionDataTask class]];
  [[[mockSesion stub]
    andDo:^(NSInvocation *invocation) {
      __unsafe_unretained void (^callback)(NSData *data, NSURLResponse *response, NSError *error);
      [invocation getArgument:&callback atIndex:3];
      [invocation setReturnValue:&_mockDataTask];
      
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
}

- (NSURLRequest *)request
{
  return [OCMockObject mockForClass:[NSURLRequest class]];
}

- (id)parseData:(NSData *)data
{
  return [OCMockObject mockForClass:[NSObject class]];
}

- (void)testTaskShouldCallbackOnMainthread
{
  __block BOOL callbackReceived = NO;
  [PTDownloadTask
   scheduledTaskWithRequester:self
   callback:^(id result, NSError *error) {
     XCTAssertTrue([NSThread isMainThread],
                   @"expecting to be called on main-thread");
     callbackReceived = YES;
   }];
  
  [self runBlock:^{
    XCTAssertTrue(callbackReceived, @"exepecting to receive callback in 2 sec");
  } withTimeout:1];
}

- (void)runBlock:(void(^)(void))block
     withTimeout:(NSTimeInterval)timeoutInSec
{
  NSDate *loopUntil = [NSDate dateWithTimeIntervalSinceNow:timeoutInSec];
  while ([loopUntil timeIntervalSinceNow] > 0) {
    [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                             beforeDate:loopUntil];
  }
  block();
}

@end
