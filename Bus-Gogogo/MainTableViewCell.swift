//
//  MainTableViewCell.swift
//  Bus-Gogogo
//
//  Created by Weijing Liu on 10/5/14.
//  Copyright (c) 2014 Weijing Liu. All rights reserved.
//

import Foundation

class MainTableViewCell: UITableViewCell {
  
  @IBOutlet weak var head: PTRoundLabel!
  @IBOutlet weak var title: UILabel!
  @IBOutlet weak var subtitle: UILabel!
  @IBOutlet weak var subline: UILabel!
  @IBOutlet weak var progressBar: CircularProgressBar!
}