//
//  RestStopsForLocationRequester.swift
//  Bus-Gogogo
//
//  Created by Weijing Liu on 10/1/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

import Foundation
import CoreLocation

class RestStopsForLocationRequester: PTDownloadRequester {
  
  var _location: CLLocation
  
  var _stops = [PTStop]()
  
  required init(location: CLLocation) {
    _location = location
  }
  
  func request() -> NSURLRequest! {
    return RestApis.Oba.stopsForLocation(_location)
  }
  
  func parseData(data: NSData!) {
    var error: NSError?
    let dict = NSJSONSerialization.JSONObjectWithData(
      data,
      options: NSJSONReadingOptions.MutableContainers,
      error: &error)
      as? NSDictionary
    assert(error == nil)
    
    let response = OBAResponse(dictionary: dict!)
    for obj in response.Data.Stops {
      _stops.append(PTStop(OBAStop: obj as OBAStop))
    }
  }
}