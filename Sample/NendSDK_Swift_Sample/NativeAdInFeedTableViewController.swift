//
//  NativeAdInFeedTableViewController.swift
//  NendSDK_Sample
//
//  Copyright © 2015年 F@N Communications. All rights reserved.
//

import UIKit

class NativeAdInFeedTableViewController: UITableViewController, NADNativeTableViewHelperDelegate {
    
    @IBOutlet private weak var footer: UIView!
    private let MAX = 200
    private var helper: NADNativeTableViewHelper!
    private var items = [String]()
    private var loading = false

    deinit {
        print("NativeAdInFeedTableViewController: deinit")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.title = "InFeed"
        
        for i in 1...100 {
            self.items.append("Item\(i)");
        }
        
        NADNativeLogger.setLogLevel(.Info)
        
        let placer = NADNativeTableViewPlacement()
        // 15行毎に広告を表示する
        placer.addRepeatInterval(15, inSection: 0)
        
        self.helper = NADNativeTableViewHelper(tableView: self.tableView, spotId: "485500", apiKey: "10d9088b5bd36cf43b295b0774e5dcf7d20a4071", advertisingExplicitly: .PR, adPlacement: placer, delegate: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44.0
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44.0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 広告行を含んだindexPathに変換しセルを取得
        let reuseIndexPath = self.helper.actualIndexPathForOriginalIndexPath(indexPath)
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: reuseIndexPath)
        // 引数のindexPathをそのまま使用
        cell.textLabel!.text = self.items[indexPath.row]
        return cell
    }

    // MARK: - Table view delegate

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // 広告行を含んだindexPathに変換し選択状態を解除
        let actualIndexPath = self.helper.actualIndexPathForOriginalIndexPath(indexPath)
        tableView.deselectRowAtIndexPath(actualIndexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if self.items.count - 1 == indexPath.row {
            if MAX == items.count {
                self.footer.removeFromSuperview()
                return
            }
            if self.loading {
                return
            }
            print("load more.")
            self.loading = true
            let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(3 * Double(NSEC_PER_SEC)))
            dispatch_after(delay, dispatch_get_main_queue(), { () -> Void in
                for i in 1...50 {
                    self.items.append("AddItem\(i)")
                }
                self.tableView.reloadData()
                self.loading = false
            })
        }
    }
    
    // MARK: - NADNativeTableViewHelperDelegate
    
    func tableView(tableView: UITableView!, adCellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        // 広告行用のセルを取得
        return tableView.dequeueReusableCellWithIdentifier("AdCell", forIndexPath: indexPath)
    }
    
    func tableView(tableView: UITableView!, heightForAdRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return 96.0
    }
    
    func tableView(tableView: UITableView!, estimatedHeightForAdRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return 96.0
    }
    
    func nadNativeDidClickAd(ad: NADNative!) {
        print("click ad.")
    }
    
    func nadNativeDidDisplayAd(ad: NADNative!, success: Bool) {
        print(#function)
    }
}
