//
//  MainViewController.swift
//  Bus-Gogogo
//
//  Created by Weijing Liu on 9/29/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class MainViewController:
  UIViewController,
  CLLocationManagerDelegate,
  UITableViewDataSource,
  UITableViewDelegate {

  @IBOutlet weak var tableView: UITableView! {
    didSet {
      tableView.tableFooterView = UIView()
    }
  }
  
  var _locationManager: CLLocationManager = CLLocationManager()
  
  var _location: CLLocation?
  
  var _closestRoutes: [ClosestRoute] = [ClosestRoute]()
  
  var _closestRouteMonitor: [RouteStopKey: String] = [RouteStopKey: String]()
  
  var _timer: NSTimer?
  
  class func key(r: PTRoute, s: PTStop) -> String {
    return r.identifier() + s.identifier
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    _locationManager.delegate = self;
  }
  
  private func fetchClosestRoute() {
    ClosestRouteProvider(location: _location) { (closestRoute, error) -> () in
      assert(error == nil, "should be nil")
      self._closestRoutes = closestRoute!
      self.tableView.reloadData()
      self.fetchMonitor()
    }
  }
  
  @objc private func fetchMonitor() {
    for c in _closestRoutes {
      RestTask(requester: RestStopMonitoringRequester(monitoringRef: c.stop.identifier, lineRef: c.route.identifier())).start
      { (req: RestStopMonitoringRequester, error: NSError!) -> () in
        var key = RouteStopKey(r: c.route, s: c.stop)
        var journey = req._monitoredJourneys.first?
        
        self._closestRouteMonitor[key] = journey?.presentableDistance
        self.tableView.reloadData()
      }
    }
  }
  
  //MARK: - Private
  private func getClosestRoute(indexPath: NSIndexPath) -> ClosestRoute {
    return _closestRoutes[indexPath.row]
  }
  
  //MARK: - UIViewController
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    _locationManager.startUpdatingLocation()
    
    _timer?.invalidate()
    _timer = NSTimer.scheduledTimerWithTimeInterval(20, target: self, selector: Selector("fetchMonitor"), userInfo: nil, repeats: true)
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    _timer?.invalidate()
  }
  
  //MARK: - CLLocationManagerDelegate
  func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
    _locationManager.stopUpdatingLocation()
    _location = locations.first as? CLLocation
    fetchClosestRoute()
  }
  
  //MARK: - UITableViewDataSource
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return _closestRoutes.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let closestRoute = _closestRoutes[indexPath.row]
    
    var identifier = NSStringFromClass(MainTableViewCell.classForCoder())
    var cell = tableView.dequeueReusableCellWithIdentifier(
      identifier, forIndexPath: indexPath) as MainTableViewCell
    cell.head.text = _closestRoutes[indexPath.row].route.shortName()
    cell.head.textColor = _closestRoutes[indexPath.row].route.textColor()
    cell.head.backgroundColor = _closestRoutes[indexPath.row].route.color()
    var dest = _closestRoutes[indexPath.row].destination
    let location = dest.rangeOfString("via").location
    if location != NSNotFound {
      dest = dest.substringToIndex(location)
    }
    cell.title.text = "To " + dest
    
    let monitor = _closestRouteMonitor[RouteStopKey(r: closestRoute.route, s: closestRoute.stop)]
    cell.subtitle.text = _closestRoutes[indexPath.row].stop.name
    cell.subline.text = (monitor == nil) ? "Not Available" : monitor!
    
    return cell
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let closestRoute = getClosestRoute(indexPath)
    let cell = tableView.cellForRowAtIndexPath(indexPath) as MainTableViewCell
    
    cell.progressBar.onTap()
    if (cell.progressBar.state == CircularProgressBar.State.Loading) {
      PTReminderManager(stop: closestRoute.stop, route: closestRoute.route, stopsAway:3)
    }
  }
  
}

class RouteStopKey: Hashable, Equatable {
  var key: String
  required init(r: PTRoute, s: PTStop) {
    key = r.identifier() + s.identifier
  }
  
  var hashValue: Int {
    return key.hashValue
  }
}
func ==(lhs: RouteStopKey, rhs: RouteStopKey) -> Bool {
  return lhs.hashValue == rhs.hashValue
}
    