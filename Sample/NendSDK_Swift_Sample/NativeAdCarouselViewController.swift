//
//  NativeAdCarouselViewController.swift
//  NendSDK_Sample
//
//  Copyright © 2016年 F@N Communications. All rights reserved.
//

import UIKit

let adPortraitWidth: CGFloat = 320 // 縦向き　広告横幅
let adPortraitHeight: CGFloat = 325 // 縦向き 広告高さ
let adLandscapeWidth: CGFloat = 580 // 横向き　広告横幅
let adLandscapeHeight: CGFloat = 200 // 横向き　広告高さ

class NativeAdCarouselViewController: UITableViewController {
    private let adRow : Int = 3
    private var items = [String]()
    private var direction : Int = 0
    
    deinit {
        print("NativeAdCarouselViewController: deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Carousel"
        
        for i in 1...100 {
            self.items.append("Item\(i)")
        }
        
        let orientation = UIApplication.sharedApplication().statusBarOrientation
        switch (orientation) {
            case UIInterfaceOrientation.Portrait, UIInterfaceOrientation.PortraitUpsideDown:
                self.direction = 1
                break
            case UIInterfaceOrientation.LandscapeLeft, UIInterfaceOrientation.LandscapeRight:
                self.direction = 2
                break
            default:
                self.direction = 0
                break
        }
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animateAlongsideTransition({(UIViewControllerTransitionCoordinatorContext) in
                if size.width <= size.height {
                    self.direction = 1
                } else {
                    self.direction = 2
                }
                self.tableView.reloadData()
            },
            completion: {(UIViewControllerTransitionCoordinatorContext) in
                NSNotificationCenter.defaultCenter().postNotificationName("layoutUpdate", object: self.direction)
            }
        )
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
        if indexPath.row == self.adRow {
            if self.direction == 1 {
                return adPortraitHeight
            } else {
                return adLandscapeHeight
            }
        }
        
        return 44.0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row == self.adRow {
            let rowId = "adcell"
            var cell = tableView.dequeueReusableCellWithIdentifier(rowId) as! NativeAdCarouselCell?
            if cell == nil {
                cell = NativeAdCarouselCell(style: UITableViewCellStyle.Default, reuseIdentifier: rowId)
                cell!.direction = self.direction
                cell!.initAd()
            }
            
            return cell!
        } else {
            let rowId = "cell"
            var cell = tableView.dequeueReusableCellWithIdentifier(rowId) as UITableViewCell?
            if cell == nil {
                cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: rowId)
            }
            
            cell!.textLabel!.text = self.items[indexPath.row]
            return cell!
        }
    }
    
    // MARK: - Table view delegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //
    }

}