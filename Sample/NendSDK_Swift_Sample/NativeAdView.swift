//
//  NativeAdView.swift
//  NendSDK_Sample
//
//  Copyright © 2015年 F@N Communications. All rights reserved.
//

import UIKit
import NendAd

class NativeAdView: UIView, NADNativeViewRendering {

    @IBOutlet fileprivate weak var nativeAdPrTextLabel: UILabel!
    @IBOutlet fileprivate weak var nativeAdShortTextLabel: UILabel!
    @IBOutlet fileprivate weak var nativeAdLongTextLabel: UILabel!
    @IBOutlet fileprivate weak var nativeAdPromotionNameLabel: UILabel!
    @IBOutlet fileprivate weak var nativeAdPromotionUrlLabel: UILabel!
    @IBOutlet fileprivate weak var nativeAdActionButtonTextLabel: UILabel!
    @IBOutlet fileprivate weak var nativeAdImageView: UIImageView!
    @IBOutlet fileprivate weak var nativeAdLogoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.borderColor = UIColor.darkGray.cgColor;
        self.layer.borderWidth = 1;
        
        self.nativeAdActionButtonTextLabel.layer.borderColor = self.nativeAdActionButtonTextLabel.textColor.cgColor;
        self.nativeAdActionButtonTextLabel.layer.borderWidth = 1;
        self.nativeAdActionButtonTextLabel.layer.masksToBounds = true;
        self.nativeAdActionButtonTextLabel.layer.cornerRadius = 0;
    }
    
    // MARK: - NADNativeViewRendering

    func prTextLabel() -> UILabel! {
        return self.nativeAdPrTextLabel
    }
    
    func shortTextLabel() -> UILabel! {
        return self.nativeAdShortTextLabel
    }
    
    func longTextLabel() -> UILabel! {
        return self.nativeAdLongTextLabel
    }
    
    func promotionNameLabel() -> UILabel! {
        return self.nativeAdPromotionNameLabel
    }
    
    func promotionUrlLabel() -> UILabel! {
        return self.nativeAdPromotionUrlLabel
    }
    
    func actionButtonTextLabel() -> UILabel! {
        return self.nativeAdActionButtonTextLabel
    }
    
    func adImageView() -> UIImageView! {
        return self.nativeAdImageView
    }
    
    func nadLogoImageView() -> UIImageView! {
        return self.nativeAdLogoImageView
    }
}
