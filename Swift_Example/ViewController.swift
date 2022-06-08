//
//  ViewController.swift
//  Swift_Example
//
//  Copyright (c) 2014年 FAN Communications. All rights reserved.
//

import UIKit
import AppTrackingTransparency
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
        if #available(iOS 14, *) {
            usingATTConsentDialog()
        }
    }
    
    @available(iOS 14, *)
    private func usingATTConsentDialog() {
        if (ATTrackingManager.trackingAuthorizationStatus == .notDetermined) {
            ATTrackingManager.requestTrackingAuthorization { (status) in
                switch (status) {
                case.authorized: fallthrough
                case.denied: fallthrough
                case.notDetermined: fallthrough
                case.restricted: fallthrough
                default:
                    break
                }
            }
        }
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ table: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "Cell")
        if #available(iOS 14.0, *) {
            var content = cell.defaultContentConfiguration()
            content.text = self.items[indexPath.row].name
            cell.contentConfiguration = content
        } else {
            cell.textLabel!.text = self.items[indexPath.row].name
        }
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: self.items[indexPath.row].segue, sender: nil)
    }
}
