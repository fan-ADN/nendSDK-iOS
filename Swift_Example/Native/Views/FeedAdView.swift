//
//  FeedAdView.swift
//  ObjC_Example
//
//  Copyright © 2015年 FAN Communications. All rights reserved.
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
        
        if #available(iOS 13, *) {
            self.backgroundColor = UIColor(named: "NativeAdBackgroundColor")
            self.nativeAdPrTextLabel.textColor = UIColor(named: "TextColor")
            self.nativeAdLongTextLabel.textColor = UIColor(named: "TextColor")
        }
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
