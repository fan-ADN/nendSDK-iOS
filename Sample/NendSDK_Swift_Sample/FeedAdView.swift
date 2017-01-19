//
//  FeedAdView.swift
//  NendSDK_Sample
//
//  Copyright © 2015年 F@N Communications. All rights reserved.
//

import UIKit
import NendAd

class FeedAdView: UIView, NADNativeViewRendering {

    @IBOutlet fileprivate weak var nativeAdPrTextLabel: UILabel!
    @IBOutlet fileprivate weak var nativeAdLongTextLabel: UILabel!
    @IBOutlet fileprivate weak var nativeAdActionButtonTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.nativeAdActionButtonTextLabel.layer.borderColor = self.nativeAdActionButtonTextLabel.textColor.cgColor;
        self.nativeAdActionButtonTextLabel.layer.borderWidth = 1;
        self.nativeAdActionButtonTextLabel.layer.masksToBounds = true;
        self.nativeAdActionButtonTextLabel.layer.cornerRadius = 0;
    }

    // MARK: - NADNativeViewRendering
    
    func prTextLabel() -> UILabel! {
        return self.nativeAdPrTextLabel
    }
    
    func longTextLabel() -> UILabel! {
        return self.nativeAdLongTextLabel
    }
    
    func actionButtonTextLabel() -> UILabel! {
        return self.nativeAdActionButtonTextLabel
    }
}
