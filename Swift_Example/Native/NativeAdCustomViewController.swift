//
//  NativeAdCustomViewController.swift
//  ObjC_Example
//
//  Copyright © 2016年 FAN Communications. All rights reserved.
//

import UIKit
import NendAd

let interval: TimeInterval = 30.0

class NativeAdCustomViewController: UIViewController, NADNativeDelegate {

    @IBOutlet weak var adImageView: UIImageView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var shortTextLabel: UILabel!
    @IBOutlet weak var longTextLabel: UILabel!
    @IBOutlet weak var prTextLabel: UILabel!
    @IBOutlet weak var promotionNameLabel: UILabel!
    @IBOutlet weak var promotionUrlLabel: UILabel!
    @IBOutlet weak var actionButtonTextLabel: UILabel!
    @IBOutlet weak var adView: UIView!
    
    fileprivate var client: NADNativeClient!
    
    deinit {
        print("NativeAdCustomViewController: deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.adView.layer.borderWidth = 1.0
        self.adView.layer.borderColor = UIColor.darkGray.cgColor
        self.actionButtonTextLabel.layer.borderColor = self.actionButtonTextLabel.textColor.cgColor
        self.actionButtonTextLabel.layer.borderWidth = 1
        self.actionButtonTextLabel.layer.masksToBounds = true
        self.actionButtonTextLabel.layer.cornerRadius = 0
        self.prTextLabel.baselineAdjustment = .alignCenters
        
        self.client = NADNativeClient(spotID: 485504, apiKey: "30fda4b3386e793a14b27bedb4dcd29f03d638e5")
        
        weak var weakSelf = self
        self.client.load() { (ad, error) in
            if let nativeAd = ad {
                weakSelf?.setUpWithAd(nativeAd)
            }
        }
    }
    
    fileprivate func setUpWithAd(_ ad: NADNative) {
        ad.delegate = self
        self.shortTextLabel.text = ad.shortText
        self.longTextLabel.text = ad.longText
        self.prTextLabel.text = ad.prText(for: .promotion)
        self.promotionNameLabel.text = ad.promotionName
        self.promotionUrlLabel.text = ad.promotionUrl
        self.actionButtonTextLabel.text = ad.actionButtonText
        ad.loadAdImage(completionBlock: {(loadAdImage) in
            self.adImageView.image = loadAdImage
        })
        ad.loadLogoImage(completionBlock: {(loadLogoImage) in
            self.logoImageView.image = loadLogoImage
        })
        ad.activateAdView(adView, withPrLabel: self.prTextLabel)
    }

    @IBAction func enableAutoReload(_ sender: AnyObject) {
        weak var weakSelf = self
        self.client.enableAutoReload(withInterval: interval, completionBlock: { (ad, error) in
            if let nativeAd = ad {
                weakSelf?.setUpWithAd(nativeAd)
            }
        })
    }
    
    @IBAction func disableAutoReload(_ sender: AnyObject) {
        self.client.disableAutoReload()
    }
    
    // MARK: - NADNativeDelegate
    func nadNativeDidClickAd(_ ad: NADNative!) {
        print(#function)
    }
}
