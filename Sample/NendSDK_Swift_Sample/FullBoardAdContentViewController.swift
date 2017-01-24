//
//  FullBoardAdContentViewController.swift
//  NendSDK_Sample
//
//  Created by user on 2017/01/18.
//  Copyright © 2017年 F@N Communications. All rights reserved.
//

import UIKit

class FullBoardAdContentViewController: UIViewController {
    
    @IBOutlet var pageLabel: UILabel!
    private var number: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.pageLabel.text = number;
    }
    
    func setNumber(number: String) {
        self.number = number as String;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
