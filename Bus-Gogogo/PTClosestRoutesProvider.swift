//
//  PTClosetRoutesProvider.swift
//  Bus-Gogogo
//
//  Created by Weijing Liu on 9/29/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

import Foundation

struct ClosestRoute {
  var route: PTRoute
  var stop: PTStop
  var destination: NSString
  var distanceText: String
}

class ClosestRouteProvider {
  
  typealias Callback = (closestRoute: [ClosestRoute]?, error: NSError?)->()
  
  var _location: CLLocation
  
  var _callback: Callback
  
  var _stops: [PTStop] = [PTStop]()
  
  var _routes: [PTRoute] = [PTRoute]()
  
  required init(
    location: CLLocation!,
    callback: Callback!) {
    _location = location
    _callback = callback
    start()
  }
  
  private func start() {
    RestTask<PTStopsForLocationRequester>(requester: PTStopsForLocationRequester(location: _location)).start {
      (requester: PTStopsForLocationRequester!, error: NSError!) -> () in
      assert(requester != nil)
      self.stopsForLocationFinish(requester)
    }
  }
  
  private func stopsForLocationFinish(requester: PTStopsForLocationRequester!) {
    let stops = requester.stops as NSArray
    _stops = [PTStop]()
    var seen = Dictionary<NSString, Int>()
    var routes = [PTRoute]()
    for ss in stops {
      let s = ss as PTStop
      _stops.append(s)
      StoreHub.stops.set(s, identifier: s.identifier)
      for obj in s.routes {
        let r = obj as PTRoute
        if seen[r.identifier()] == nil {
          seen[r.identifier()] = 1
          routes.append(r)
        }
      }
    }
    
    _routes = routes
    var requesters = [PTStopGroupDownloadRequester]()
    
    for r in routes {
      RestTask(requester: PTStopGroupDownloadRequester(routeId: r.identifier())).start {
        (r: PTStopGroupDownloadRequester?, e: NSError?) -> () in
        requesters.append(r!)
        if requesters.count == routes.count {
          self.stopGroupRequestersFinish(requesters)
        }
      }
      NSLog("%@", r.identifier())
    }
    NSLog("finish")
  }
  
  private func stopGroupRequestersFinish(requesters: [PTStopGroupDownloadRequester]) {
    
    // ------
    var ret = [ClosestRoute]()
    NSLog("stopgroups=%d", requesters.count)
    for r in requesters {
      let route = PTRoute(OBACounterPart: r.response().Data.Route)
      let stopGrouping = r.response().Data.StopGroupings.firstObject as OBAStopGrouping
      for g in stopGrouping.StopGroups {
        let stopGroup = g as OBAStopGroup
        let destination = stopGroup.Name.Name
        // find <route, directText>
        let stop = findClosestStop(stopGroup.StopIds)
        let distance = Int(stop.location.distanceFromLocation(_location))
        let distanceText = NSString(format: "%dm", distance)
        ret.append(ClosestRoute(route: route, stop: stop, destination: destination, distanceText: distanceText))
      }
    }
    _callback(closestRoute: ret, error: nil)
  }
  
  private func findClosestStop(stopIds: NSArray!) -> PTStop {
    NSLog("%d", stopIds.count)
    var bestDistance = 10000000.0
    var bestStop = PTStop()
    for s in _stops {
      if stopIds.containsObject(s.identifier) {
        var dist = s.location.distanceFromLocation(_location)
        if dist < bestDistance {
          bestStop = s
          bestDistance = dist
        }
      }
    }
    NSLog("%lf", bestDistance)
    return bestStop
  }
}

