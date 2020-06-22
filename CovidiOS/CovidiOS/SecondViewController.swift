//
//  SecondViewController.swift
//  CovidiOS
//
//  Created by Nguyen Duc Manh on 6/22/20.
//  Copyright © 2020 Nguyen Duc Manh. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController{
    
    @IBOutlet weak var lblConfirmed: UILabel!
    var confirmed: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        lblConfirmed.text = String(confirmed)
    }
    
}
