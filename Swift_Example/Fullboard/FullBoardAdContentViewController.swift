//
//  FullBoardAdContentViewController.swift
//  ObjC_Example
//
//  Copyright © 2017年 FAN Communications. All rights reserved.
//

import UIKit

class FullBoardAdContentViewController: UIViewController {
    
    @IBOutlet fileprivate weak var pageLabel: UILabel!
    var number: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.pageLabel.text = number;
    }
}
