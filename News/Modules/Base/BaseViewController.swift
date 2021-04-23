//
//  BaseViewController.swift
//  MathSolver
//
//  Created by Mehmet Kerem Keskin on 16.12.2020.
//  Copyright © 2020 MathSolver. All rights reserved.
//

import UIKit
import MessageUI

class BaseViewController: UIViewController {
    
    var screenName: String {
        return "#" + self.className
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
