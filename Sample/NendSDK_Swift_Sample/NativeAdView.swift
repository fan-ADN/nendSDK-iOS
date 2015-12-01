//
//  NativeAdView.swift
//  NendSDK_Sample
//
//  Copyright © 2015年 F@N Communications. All rights reserved.
//

import UIKit

class NativeAdView: UIView, NADNativeViewRendering {

    @IBOutlet private weak var nativeAdPrTextLabel: NADNativeLabel!
    @IBOutlet private weak var nativeAdShortTextLabel: NADNativeLabel!
    @IBOutlet private weak var nativeAdLongTextLabel: NADNativeLabel!
    @IBOutlet private weak var nativeAdPromotionNameLabel: NADNativeLabel!
    @IBOutlet private weak var nativeAdPromotionUrlLabel: NADNativeLabel!
    @IBOutlet private weak var nativeAdActionButtonTextLabel: NADNativeLabel!
    @IBOutlet private weak var nativeAdImageView: NADNativeImageView!
    @IBOutlet private weak var nativeAdLogoImageView: NADNativeImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.borderColor = UIColor.darkGrayColor().CGColor;
        self.layer.borderWidth = 1;
        
        self.nativeAdActionButtonTextLabel.layer.borderColor = self.nativeAdActionButtonTextLabel.textColor.CGColor;
        self.nativeAdActionButtonTextLabel.layer.borderWidth = 1;
        self.nativeAdActionButtonTextLabel.layer.masksToBounds = true;
        self.nativeAdActionButtonTextLabel.layer.cornerRadius = 0;
    }
    
    // MARK: - NADNativeViewRendering

    func prTextLabel() -> NADNativeLabel! {
        return self.nativeAdPrTextLabel
    }
    
    func shortTextLabel() -> NADNativeLabel! {
        return self.nativeAdShortTextLabel
    }
    
    func longTextLabel() -> NADNativeLabel! {
        return self.nativeAdLongTextLabel
    }
    
    func promotionNameLabel() -> NADNativeLabel! {
        return self.nativeAdPromotionNameLabel
    }
    
    func promotionUrlLabel() -> NADNativeLabel! {
        return self.nativeAdPromotionUrlLabel
    }
    
    func actionButtonTextLabel() -> NADNativeLabel! {
        return self.nativeAdActionButtonTextLabel
    }
    
    func adImageView() -> NADNativeImageView! {
        return self.nativeAdImageView
    }
    
    func logoImageView() -> NADNativeImageView! {
        return self.nativeAdLogoImageView
    }
}
