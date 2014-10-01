//
//  RestRequest.swift
//  Bus-Gogogo
//
//  Created by Weijing Liu on 10/1/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

import Foundation

extension NSURL {
  class Builder {
   
    var _urlText: String = String()
    
    var _hasParam: Bool = false
    
    func query(query: String) -> Builder {
      _urlText += query
      return self
    }
    
    func param(key: String, value: Double) -> Builder {
      return param(key, value: "\(value)")
    }
    
    func param(key: String, value: String) -> Builder {
      let separator = _hasParam ? "&" : "?"
      _hasParam = true
      _urlText += separator + key + "=" + value
      return self
    }
    
    func build() -> NSURL {
      return NSURL(string: _urlText)
    }
  }
}
