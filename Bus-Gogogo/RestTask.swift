//
//  PTDownloadTask.swift
//  Bus-Gogogo
//
//  Created by Weijing Liu on 9/30/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

import Foundation

protocol RestRequester {
  func request() -> NSURLRequest
  func parse(data: NSData)
}

class RestTask<T where T: PTDownloadRequester> {
  
  typealias Callback = (T, NSError!)->()
  
  private var _requester: T
  
  private var _session: NSURLSession?
  
  private var _dataTask: NSURLSessionDataTask?
  
  required init(requester: T) {
    _requester = requester
  }
  
  func start(callback: Callback) {
    var config = NSURLSessionConfiguration.defaultSessionConfiguration()
    config.requestCachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData
    _dataTask = NSURLSession(configuration: config).dataTaskWithRequest(_requester.request())
    { (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
      if error == nil {
        self._requester.parseData(data!)
      }
      dispatch_async(dispatch_get_main_queue()) {
        callback(self._requester, error)
      }
    }
    _dataTask?.resume()
  }
  
  func cancel() {
    _dataTask?.cancel()
  }
}