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
  
  var _closestRoutes: [ClosestRoute]?
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    _locationManager.delegate = self;
  }
  
  private func fetchClosestRoute() {
    ClosestRouteProvider(location: _location) { (closestRoute, error) -> () in
      assert(error == nil, "should be nil")
      self._closestRoutes = closestRoute
      self.tableView.reloadData()
    }
  }
  
  // UIViewController______________________________
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    _locationManager.startUpdatingLocation()
  }
  
  // CLLocationManagerDelegate_____________________
  func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
    _locationManager.stopUpdatingLocation()
    _location = locations.first as? CLLocation
    fetchClosestRoute()
  }
  
  // UITableViewDataSource__________________________
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let routes = _closestRoutes? {
      return routes.count
    } else {
      return 0
    }
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var identifier = NSStringFromClass(PTMainTableViewCell.classForCoder())
    var cell = tableView.dequeueReusableCellWithIdentifier(
      identifier, forIndexPath: indexPath) as PTMainTableViewCell
    cell.head.text = _closestRoutes![indexPath.row].route.shortName()
    cell.head.textColor = _closestRoutes![indexPath.row].route.textColor()
    cell.head.backgroundColor = _closestRoutes![indexPath.row].route.color()
    var dest = _closestRoutes![indexPath.row].destination
    let location = dest.rangeOfString("via").location
    if location != NSNotFound {
      dest = dest.substringToIndex(location)
    }
    cell.title.text = "To " + dest
    cell.subtitle.text = _closestRoutes![indexPath.row].stop.name
    return cell
  }
}