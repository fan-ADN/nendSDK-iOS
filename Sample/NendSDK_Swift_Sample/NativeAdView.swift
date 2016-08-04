//
//  NativeAdView.swift
//  NendSDK_Sample
//
//  Copyright © 2015年 F@N Communications. All rights reserved.
//

import UIKit

class NativeAdView: UIView, NADNativeViewRendering {

    @IBOutlet private weak var nativeAdPrTextLabel: UILabel!
    @IBOutlet private weak var nativeAdShortTextLabel: UILabel!
    @IBOutlet private weak var nativeAdLongTextLabel: UILabel!
    @IBOutlet private weak var nativeAdPromotionNameLabel: UILabel!
    @IBOutlet private weak var nativeAdPromotionUrlLabel: UILabel!
    @IBOutlet private weak var nativeAdActionButtonTextLabel: UILabel!
    @IBOutlet private weak var nativeAdImageView: UIImageView!
    @IBOutlet private weak var nativeAdLogoImageView: UIImageView!
    
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
    
    func logoImageView() -> UIImageView! {
        return self.nativeAdLogoImageView
    }
}
