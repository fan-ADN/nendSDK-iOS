//
//  NativeAdCustomViewController.swift
//  NendSDK_Sample
//
//  Copyright © 2016年 F@N Communications. All rights reserved.
//

import UIKit
let interval: NSTimeInterval = 30.0

class NativeAdCustomViewController: UIViewController, NADNativeDelegate {

    @IBOutlet weak var adImage: UIImageView!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var shortText: UILabel!
    @IBOutlet weak var longText: UILabel!
    @IBOutlet weak var prText: UILabel!
    @IBOutlet weak var promotionName: UILabel!
    @IBOutlet weak var promotionUrl: UILabel!
    @IBOutlet weak var buttonText: UILabel!
    @IBOutlet weak var adView: UIView!
    
    private var client: NADNativeClient!
    
    deinit {
        print("NativeAdCustomViewController: deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NADNativeLogger.setLogLevel(.Debug)
        self.client = NADNativeClient(spotId: "485504", apiKey: "30fda4b3386e793a14b27bedb4dcd29f03d638e5")
        
        weak var weakSelf = self
        self.client.loadWithCompletionBlock() { (ad, error) in
            if let nativeAd = ad {
                weakSelf?.setUpWithAd(nativeAd)
            }
        }
    }
    
    private func setUpWithAd(ad: NADNative) {
        ad.delegate = self
        self.shortText.text = ad.shortText
        self.longText.text = ad.longText
        self.prText.text = ad.prTextForAdvertisingExplicitly(.Promotion)
        self.promotionName.text = ad.promotionName
        self.promotionUrl.text = ad.promotionUrl
        self.buttonText.text = ad.actionButtonText
        ad.loadAdImageWithCompletionBlock({(i) in
            self.adImage.image = i
        })
        ad.loadLogoImageWithCompletionBlock({(i) in
            self.logoImage.image = i
        })
        ad.activateAdView(adView, withPrLabel: self.prText)
    }

    @IBAction func enableAutoReload(sender: AnyObject) {
        weak var weakSelf = self
        self.client.enableAutoReloadWithInterval(interval, completionBlock: { (ad, error) in
            if let nativeAd = ad {
                weakSelf?.setUpWithAd(nativeAd)
            }
        })
    }
    
    @IBAction func disableAutoReload(sender: AnyObject) {
        self.client.disableAutoReload()
    }
    
    // MARK: - NADNativeDelegate
    func nadNativeDidClickAd(ad: NADNative!) {
        print(#function)
    }
}