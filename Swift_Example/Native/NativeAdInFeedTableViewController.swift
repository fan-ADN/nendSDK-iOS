//
//  NativeAdInFeedTableViewController.swift
//  ObjC_Example
//
//  Copyright © 2015年 FAN Communications. All rights reserved.
//

import UIKit
import NendAd

class NativeAdInFeedTableViewController: UITableViewController, NADNativeTableViewHelperDelegate {
    
    @IBOutlet fileprivate weak var footer: UIView!
    fileprivate let MAX = 200
    fileprivate var helper: NADNativeTableViewHelper!
    fileprivate var items = [String]()
    fileprivate var loading = false

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
        
        let placer = NADNativeTableViewPlacement()
        // 15行毎に広告を表示する
        placer.addRepeatInterval(15, inSection: 0)
        
        self.helper = NADNativeTableViewHelper(tableView: self.tableView, spotID: 485500, apiKey: "10d9088b5bd36cf43b295b0774e5dcf7d20a4071", advertisingExplicitly: .PR, adPlacement: placer, delegate: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 広告行を含んだindexPathに変換しセルを取得
        let reuseIndexPath = self.helper.actualIndexPath(forOriginalIndexPath: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: reuseIndexPath!)
        // 引数のindexPathをそのまま使用
        if #available(iOS 14.0, *) {
            var content = cell.defaultContentConfiguration()
            content.text = self.items[indexPath.row]
            cell.contentConfiguration = content
        } else {
            cell.textLabel!.text = self.items[indexPath.row]
        }
        return cell
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 広告行を含んだindexPathに変換し選択状態を解除
        let actualIndexPath = self.helper.actualIndexPath(forOriginalIndexPath: indexPath)
        tableView.deselectRow(at: actualIndexPath!, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
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
            let delay = DispatchTime.now() + Double(Int64(3 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: delay, execute: { () -> Void in
                for i in 1...50 {
                    self.items.append("AddItem\(i)")
                }
                self.tableView.reloadData()
                self.loading = false
            })
        }
    }
    
    // MARK: - NADNativeTableViewHelperDelegate
    
    func tableView(_ tableView: UITableView!, adCellForRowAt indexPath: IndexPath!) -> UITableViewCell! {
        // 広告行用のセルを取得
        return tableView.dequeueReusableCell(withIdentifier: "AdCell", for: indexPath)
    }
    
    func tableView(_ tableView: UITableView!, heightForAdRowAt indexPath: IndexPath!) -> CGFloat {
        return 96.0
    }
    
    func tableView(_ tableView: UITableView!, estimatedHeightForAdRowAt indexPath: IndexPath!) -> CGFloat {
        return 96.0
    }
    
    func nadNativeDidClickAd(_ ad: NADNative!) {
        print("click ad.")
    }
}
