//
//  RestRequest.swift
//  Bus-Gogogo
//
//  Created by Weijing Liu on 10/1/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

import Foundation

extension NSURL {
  class Builder: Printable {
   
    private var _query: String = String()
    
    private var _params: String = String()
    
    var description: String {
      return build().description
    }
    
    func query(query: String) -> Builder {
      _query = query
      return self
    }
    
    func param(key: String, value: Double) -> Builder {
      return param(key, value: "\(value)")
    }
    
    func param(key: String, var value: String) -> Builder {
      var separator = _params.isEmpty ? "" : "&"
      _params += separator + key + "=" + format(value)
      return self
    }
    
    func build() -> NSURL {
      assert(!_query.isEmpty, "query is invalid")
      if _params.isEmpty {
        return NSURL(string: _query)
      } else {
        return NSURL(string: _query + "?" + _params)
      }
    }
    
    // Used to format string values to be compatible to URL standard, i.e. space replacement.
    private func format(string: String) -> String {
      return string.stringByReplacingOccurrencesOfString(" ", withString: "%20")
    }
  }
}
