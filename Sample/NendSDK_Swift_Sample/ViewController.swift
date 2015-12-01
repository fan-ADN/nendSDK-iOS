//
//  ViewController.swift
//  NendSDK_Swift_Sample
//
//  Created by ADN on 2014/10/03.
//  Copyright (c) 2014年 F@N Communications. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let items = [
        (name: "320x50", segue: "PushMobileBigBanner"),
        (name: "320x100", segue: "PushMobileBanner"),
        (name: "300x100", segue: "PushThreeOneRectangle"),
        (name: "300x250", segue: "PushMediumRectangle"),
        (name: "728x90", segue: "PushBigBanner"),
        (name: "Interstitial", segue: "PushInterstitialAd"),
        (name: "Native", segue: "PushNativeAdMenu")
    ]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "NendSwiftSample"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath:NSIndexPath!) -> UITableViewCell! {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        cell.textLabel!.text = self.items[indexPath.row].name
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.performSegueWithIdentifier(self.items[indexPath.row].segue, sender: nil)
    }
}
