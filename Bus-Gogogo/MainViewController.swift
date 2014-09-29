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

  @IBOutlet weak var tableView: UITableView!
  
  var _locationManager: CLLocationManager = CLLocationManager()
  
  var _location: CLLocation?
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    _locationManager.delegate = self;
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
  }
  
  // UITableViewDataSource__________________________
  func tableView(
    tableView: UITableView,
    numberOfRowsInSection section: Int) -> Int {
    return 2;
  }
  
  func tableView(
    tableView: UITableView,
    cellForRowAtIndexPath indexPath: NSIndexPath)
    -> UITableViewCell {
    var identifier = NSStringFromClass(PTMainTableViewCell.classForCoder())
    var cell = tableView.dequeueReusableCellWithIdentifier(
      identifier, forIndexPath: indexPath) as UITableViewCell
    return cell
  }
}