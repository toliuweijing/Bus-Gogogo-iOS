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
    PTDownloadTask.scheduledTaskWithRequester(
      PTStopsForLocationRequester(location: _location),
      callback: { (obj: AnyObject!, error: NSError!) -> Void in
        let requester = obj as? PTStopsForLocationRequester
        self.stopsForLocationFinish(requester)
    })
  }
  
  private func stopsForLocationFinish(requester: PTStopsForLocationRequester!) {
    let stops = requester.stops as [PTStop]
    var seen = Dictionary<NSString, Int>()
    var routes = [PTRoute]()
    for s in stops {
      StoreHub.stops.set(s, identifier: s.identifier)
      for obj in s.routes {
        let r = obj as PTRoute
        if seen[r.identifier()] == nil {
          seen[r.identifier()] = 1
          routes.append(r)
        }
      }
    }
    
    _stops = stops
    _routes = routes
    var requesters = [PTStopGroupDownloadRequester]()
    
    for r in routes {
      PTDownloadTask.scheduledTaskWithRequester(
        PTStopGroupDownloadRequester(routeId: r.identifier()),
        callback: { (obj: AnyObject!, error: NSError!) -> Void in
          let requester = obj as PTStopGroupDownloadRequester
          requesters.append(requester)
          
          if requesters.count == routes.count {
            self.stopGroupRequestersFinish(requesters)
          }
      })
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
        NSLog("route=%@, stop=%@, distination=%@", route.identifier(), stop.identifier, destination)
        ret.append(ClosestRoute(route: route, stop: stop, destination: destination, distanceText: distanceText))
      }
    }
    _callback(closestRoute: ret, error: nil)
  }
  
  private func findClosestStop(stopIds: NSArray!) -> PTStop {
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

