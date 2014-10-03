//
//  RestStopMonitoringRequester.swift
//  Bus-Gogogo
//
//  Created by Weijing Liu on 10/2/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

import Foundation

class RestStopMonitoringRequester: PTDownloadRequester {
  
  var _monitoringRef: String
  
  var _lineRef: String
  
  var _monitoredJourneys: [PTMonitoredVehicleJourney] = [PTMonitoredVehicleJourney]()
  
  class func sample() -> RestStopMonitoringRequester {
    return RestStopMonitoringRequester(monitoringRef: "MTA_300071", lineRef: "MTA NYCT_B9")
  }
  
  required init(monitoringRef: String, lineRef: String) {
    _monitoringRef = monitoringRef
    _lineRef = lineRef
  }
  
  func request() -> NSURLRequest! {
    return RestApis.Siri.stopMonitoring(_monitoringRef, lineRef: _lineRef)
  }
  
  func parseData(data: NSData!) {
    var error: NSError?
    var json = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as NSDictionary?
    NSLog("%@", json!)
    if error != nil {
      return
    }
    
    var mta = MTAResponse(dictionary: json)
    var delivery = mta.Siri.ServiceDelivery.StopMonitoringDelivery.firstObject as MTAStopMonitoringDelivery
    for visit in delivery.MonitoredStopVisit {
      var journey = PTMonitoredVehicleJourney(MTACounterPart: visit.MonitoredVehicleJourney)
      _monitoredJourneys.append(journey)
    }
  }
}