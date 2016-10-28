//
//  NativeAdCollectionViewController.swift
//  NendSDK_Sample
//
//  Copyright © 2015年 F@N Communications. All rights reserved.
//

import UIKit

class NativeAdCollectionViewController: UICollectionViewController {
    
    private var ads = [NADNative]()
    private let adInterval = 10
    private let itemCount = 100
    private let client = NADNativeClient(spotId: "485502", apiKey: "a3972604a76864dd110d0b02204f4b72adb092ae")
    private let colors = [UIColor.redColor(), UIColor.blueColor(), UIColor.yellowColor(), UIColor.greenColor(), UIColor.purpleColor(), UIColor.orangeColor()]

    deinit {
        print("NativeAdCollectionViewController: deinit")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes

        // Do any additional setup after loading the view.
        
        self.title = "Collection"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCount + itemCount / adInterval
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if self.isAdRow(indexPath.row) {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("AdCell", forIndexPath: indexPath) as! NativeAdCollectionView
            
            self.client.loadWithCompletionBlock({ (ad, error) -> Void in
                if let nativeAd = ad {
                    self.ads.append(nativeAd)
                    nativeAd.intoView(cell, advertisingExplicitly: .AD)
                } else {
                    if self.ads.count == 0 {
                        return;
                    }
                    self.adFromCache(indexPath).intoView(cell, advertisingExplicitly: .AD)
                }
                
                let paragrahStyle = NSMutableParagraphStyle()
                paragrahStyle.minimumLineHeight = 15.0
                paragrahStyle.maximumLineHeight = 15.0
                
                let attributedText = NSMutableAttributedString(string: ad.shortText)
                attributedText.addAttributes([NSParagraphStyleAttributeName: paragrahStyle], range: NSMakeRange(0, attributedText.length))
                
                cell.shortTextLabel().numberOfLines = 0
                cell.shortTextLabel().attributedText = attributedText
            })
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath)
            cell.contentView.backgroundColor = self.colors[(indexPath.row - indexPath.row / adInterval) % self.colors.count]
            return cell
        }
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        if !self.isAdRow(indexPath.row) {
            print("Click normal cell.")
        }
    }
    
    // MARK: Private
    
    private func isAdRow(row: Int) -> Bool {
        return adInterval == row % (adInterval + 1)
    }
    
    private func adFromCache(indexPath: NSIndexPath) -> NADNative {
        let pos = (indexPath.row / adInterval - 1) % self.ads.count
        return self.ads[pos]
    }
}
