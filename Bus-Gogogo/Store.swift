//
//  Store.swift
//  Bus-Gogogo
//
//  Created by Weijing Liu on 9/29/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

import Foundation

class Store<T> {
  
  var _dict: Dictionary<NSString, T> = Dictionary<NSString, T>()
  
  func get(identifier: NSString) -> T? {
    return _dict[identifier]
  }
  
  func set(obj: T, identifier: NSString) {
    _dict[identifier] = obj
  }
}

struct StoreHub {
  static let stops: Store<PTStop> = Store<PTStop>()
  static let routes: Store<PTRoute> = Store<PTRoute>()
  static let stopGroups: Store<PTStopGroup> = Store<PTStopGroup>()
}

