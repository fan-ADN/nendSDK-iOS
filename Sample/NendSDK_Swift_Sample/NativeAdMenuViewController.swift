//
//  NativeAdMenuViewController.swift
//  NendSDK_Sample
//
//  Copyright (c) 2015年 F@N Communications. All rights reserved.
//

import UIKit

class NativeAdMenuViewController: UITableViewController {
    
    private let items = [
        (name: "SmallSquare", segue: "PushSimpleNativeAd"),
        (name: "SmallWide", segue: "PushSimpleNativeAd"),
        (name: "LargeWide", segue: "PushSimpleNativeAd"),
        (name: "TextOnly", segue: "PushSimpleNativeAd"),
        (name: "InFeed", segue: "PushInFeedNativeAd"),
        (name: "Collection", segue: "PushCollectionNativeAd"),
        (name: "Page", segue: "PushPageNativeAd"),
        (name: "RSS", segue: "PushRssNativeAd"),
    ]
    
    private let details = [
        (apiKey: "10d9088b5bd36cf43b295b0774e5dcf7d20a4071", spotId: "485500", nibName: "NativeAdViewSmallSquare"),
        (apiKey: "a3972604a76864dd110d0b02204f4b72adb092ae", spotId: "485502", nibName: "NativeAdViewSmallWide"),
        (apiKey: "30fda4b3386e793a14b27bedb4dcd29f03d638e5", spotId: "485504", nibName: "NativeAdViewLargeWide"),
        (apiKey: "31e861edb574cfa0fb676ebdf0a0b9a0621e19fc", spotId: "485507", nibName: "NativeAdViewTextOnly")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.title = "NativeAd"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.items.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        // Configure the cell...
        cell.textLabel!.text = self.items[indexPath.row].name
        cell.accessoryType = .DisclosureIndicator

        return cell
    }

    // MARK: - Table view delegate

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier(self.items[indexPath.row].segue, sender: indexPath)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if "PushSimpleNativeAd" == segue.identifier {
            if let indexPath = sender as? NSIndexPath {
                if let vc = segue.destinationViewController as? NativeAdViewController {
                    let detail = self.details[indexPath.row]
                    vc.spotId = detail.spotId
                    vc.apiKey = detail.apiKey
                    vc.nib = detail.nibName
                }
            }
        }
    }
}
