//
//  NativeAdMenuViewController.swift
//  ObjC_Example
//
//  Copyright (c) 2015年 FAN Communications. All rights reserved.
//

import UIKit

class NativeAdMenuViewController: UITableViewController {
    
    fileprivate let items = [
        (name: "SmallSquare", segue: "PushSimpleNativeAd"),
        (name: "LargeWide", segue: "PushSimpleNativeAd"),
        (name: "TextOnly", segue: "PushSimpleNativeAd"),
        (name: "InFeed", segue: "PushInFeedNativeAd"),
        (name: "Collection", segue: "PushCollectionNativeAd"),
        (name: "Page", segue: "PushPageNativeAd"),
        (name: "RSS", segue: "PushRssNativeAd"),
        (name: "Carousel", segue: "PushCarouselNativeAd"),
        (name: "Custom", segue: "PushCustomNativeAd")
    ]
    
    fileprivate let details = [
        (apiKey: "10d9088b5bd36cf43b295b0774e5dcf7d20a4071", spotId: "485500", nibName: "NativeAdViewSmallSquare"),
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

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // Configure the cell...
        cell.textLabel!.text = self.items[indexPath.row].name
        cell.accessoryType = .disclosureIndicator

        return cell
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: self.items[indexPath.row].segue, sender: indexPath)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if "PushSimpleNativeAd" == segue.identifier {
            if let indexPath = sender as? IndexPath {
                if let vc = segue.destination as? NativeAdViewController {
                    let detail = self.details[indexPath.row]
                    vc.spotId = detail.spotId
                    vc.apiKey = detail.apiKey
                    vc.nib = detail.nibName
                }
            }
        }
    }
}
