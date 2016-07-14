//
//  NativeAdCustomViewController.swift
//  NendSDK_Sample
//
//  Copyright © 2016年 F@N Communications. All rights reserved.
//

import UIKit
let interval: NSTimeInterval = 30.0

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
        self.shortTextLabel.text = ad.shortText
        self.shortTextLabel.adjustsFontSizeToFitWidth = true;
        self.longTextLabel.text = ad.longText
        self.longTextLabel.adjustsFontSizeToFitWidth = true;
        self.prTextLabel.text = ad.prTextForAdvertisingExplicitly(.Promotion)
        self.prTextLabel.adjustsFontSizeToFitWidth = true;
        self.promotionNameLabel.text = ad.promotionName
        self.promotionUrlLabel.text = ad.promotionUrl
        self.actionButtonTextLabel.text = ad.actionButtonText
        ad.loadAdImageWithCompletionBlock({(loadAdImage) in
            self.adImageView.image = loadAdImage
        })
        ad.loadLogoImageWithCompletionBlock({(loadLogoImage) in
            self.logoImageView.image = loadLogoImage
        })
        ad.activateAdView(adView, withPrLabel: self.prTextLabel)
        self.adView.layer.borderWidth = 1.0;
        self.adView.layer.borderColor = UIColor.darkGrayColor().CGColor;
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