//
//  RestApi.swift
//  Bus-Gogogo
//
//  Created by Weijing Liu on 10/1/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

import Foundation
import CoreLocation

struct RestApis {
  static let PARAM_KEY = "key"
  static let VAL_KEY = "c6e4158f-c556-44ce-9048-597ec09c5d46"
  
  struct Siri {
    
  }
  
  struct Oba {
    
    static let FORMAT = "http://api.prod.obanyc.com/api/where/%@.json"
    
    static let QUERY_STOPS_FOR_LOCATION = NSString(format: FORMAT, "stops-for-location")
    
    static func stopsForLocation(location: CLLocation) -> NSURLRequest {
      let url = NSURL.Builder()
        .query(NSString(format: FORMAT, "stops-for-location"))
        .param(PARAM_KEY, value: VAL_KEY)
        .param("lat", value: location.coordinate.latitude)
        .param("lon", value: location.coordinate.longitude)
        .build()
      return NSURLRequest(URL: url)
    }
  }
  
}