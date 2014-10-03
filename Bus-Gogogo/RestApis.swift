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
    
    static let FORMAT = "http://api.prod.obanyc.com/api/siri/%@.json"
    
    static let QUERY_STOP_MONITORING = "stop-monitoring"
    
    static let PARAM_MONITORING_REF = "MonitoringRef"
    
    static let PARAM_LINE_REF = "LineRef"
    
    static func stopMonitoring(monitoringRef: String, lineRef: String)
      -> NSURLRequest {
      let url = NSURL.Builder()
        .query(NSString(format: FORMAT, QUERY_STOP_MONITORING))
        .param(PARAM_KEY, value: VAL_KEY)
        .param(PARAM_MONITORING_REF, value: monitoringRef)
        .param(PARAM_LINE_REF, value: lineRef)
        .build()
      return NSURLRequest(URL: url)
    }
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