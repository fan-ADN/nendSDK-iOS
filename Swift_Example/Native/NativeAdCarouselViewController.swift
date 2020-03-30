//
//  NativeAdCarouselViewController.swift
//  ObjC_Example
//
//  Copyright © 2016年 FAN Communications. All rights reserved.
//

import UIKit

let adPortraitWidth: CGFloat = 320 // 縦向き　広告横幅
let adPortraitHeight: CGFloat = 325 // 縦向き 広告高さ
let adLandscapeWidth: CGFloat = 580 // 横向き　広告横幅
let adLandscapeHeight: CGFloat = 200 // 横向き　広告高さ

class NativeAdCarouselViewController: UITableViewController {
    fileprivate let adRow : Int = 3
    fileprivate var items = [String]()
    fileprivate var direction : Int = 0
    
    deinit {
        print("NativeAdCarouselViewController: deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Carousel"
        
        for i in 1...100 {
            self.items.append("Item\(i)")
        }
        
        let orientation = UIApplication.shared.statusBarOrientation
        switch (orientation) {
            case UIInterfaceOrientation.portrait, UIInterfaceOrientation.portraitUpsideDown:
                self.direction = 1
            case UIInterfaceOrientation.landscapeLeft, UIInterfaceOrientation.landscapeRight:
                self.direction = 2
            default:
                self.direction = 0
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: {(UIViewControllerTransitionCoordinatorContext) in
                if size.width <= size.height {
                    self.direction = 1
                } else {
                    self.direction = 2
                }
                self.tableView.reloadData()
            },
            completion: {(UIViewControllerTransitionCoordinatorContext) in
                NotificationCenter.default.post(name: Notification.Name(rawValue: "layoutUpdate"), object: self.direction)
            }
        )
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
        if indexPath.row == self.adRow {
            if self.direction == 1 {
                return adPortraitHeight
            } else {
                return adLandscapeHeight
            }
        }
        
        return 44.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == self.adRow {
            let rowId = "adcell"
            var cell = tableView.dequeueReusableCell(withIdentifier: rowId) as! NativeAdCarouselCell?
            if cell == nil {
                cell = NativeAdCarouselCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: rowId)
                cell!.direction = self.direction
                cell!.initAd()
            }
            
            return cell!
        } else {
            let rowId = "cell"
            var cell = tableView.dequeueReusableCell(withIdentifier: rowId) as UITableViewCell?
            if cell == nil {
                cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: rowId)
            }
            
            cell!.textLabel!.text = self.items[indexPath.row]
            return cell!
        }
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }

}
