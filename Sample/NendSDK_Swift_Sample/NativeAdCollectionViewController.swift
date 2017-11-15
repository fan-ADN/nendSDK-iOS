//
//  NativeAdCollectionViewController.swift
//  NendSDK_Sample
//
//  Copyright © 2015年 F@N Communications. All rights reserved.
//

import UIKit
import NendAd

class NativeAdCollectionViewController: UICollectionViewController {
    
    fileprivate var ads = [NADNative]()
    fileprivate let adInterval = 10
    fileprivate let itemCount = 100
    fileprivate let client = NADNativeClient(spotId: "485504", apiKey: "30fda4b3386e793a14b27bedb4dcd29f03d638e5")
    fileprivate let colors = [UIColor.red, UIColor.blue, UIColor.yellow, UIColor.green, UIColor.purple, UIColor.orange]

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

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCount + itemCount / adInterval
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if self.isAdRow(indexPath.row) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdCell", for: indexPath) as! NativeAdCollectionView
            
            self.client?.load(completionBlock: { (ad, error) -> Void in
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
                
                let attributedText = NSMutableAttributedString(string: (ad?.shortText)!)
                attributedText.addAttributes([NSParagraphStyleAttributeName: paragrahStyle], range: NSMakeRange(0, attributedText.length))
                
                cell.shortTextLabel().numberOfLines = 0
                cell.shortTextLabel().attributedText = attributedText
            })
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
            cell.contentView.backgroundColor = self.colors[(indexPath.row - indexPath.row / adInterval) % self.colors.count]
            return cell
        }
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if !self.isAdRow(indexPath.row) {
            print("Click normal cell.")
        }
    }
    
    // MARK: Private
    
    fileprivate func isAdRow(_ row: Int) -> Bool {
        return adInterval == row % (adInterval + 1)
    }
    
    fileprivate func adFromCache(_ indexPath: IndexPath) -> NADNative {
        let pos = (indexPath.row / adInterval - 1) % self.ads.count
        return self.ads[pos]
    }
}
