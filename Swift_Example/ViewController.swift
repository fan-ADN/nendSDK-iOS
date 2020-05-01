//
//  ViewController.swift
//  Swift_Example
//
//  Copyright (c) 2014年 FAN Communications. All rights reserved.
//

import UIKit
import NendAd

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let items = [
        (name: "Banner", segue: "BannerExamples"),
        (name: "Interstitial", segue: "InterstitialExamples"),
        (name: "Native", segue: "PushNativeAdMenu"),
        (name: "FullBoard", segue: "PushFullBoardAdMenu"),
        (name: "Video", segue: "PushVideoAdMenu"),
        (name: "NativeVideo", segue: "PushVideoNative"),
        (name: "InFeed(NativeVideo)", segue: "PushInFeedAdMenu")
    ]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "SwiftExample"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ table: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "Cell")
        cell.textLabel!.text = self.items[indexPath.row].name
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: self.items[indexPath.row].segue, sender: nil)
    }
}
