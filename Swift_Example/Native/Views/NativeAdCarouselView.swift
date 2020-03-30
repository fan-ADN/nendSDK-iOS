//
//  NativeAdCarouselView.swift
//  ObjC_Example
//
//  Copyright © 2016年 FAN Communications. All rights reserved.
//

import UIKit
import NendAd

class NativeAdCarouselView: UIView, NADNativeViewRendering {
    
    @IBOutlet fileprivate weak var nativeAdPrTextLabel: UILabel!
    @IBOutlet fileprivate weak var nativeAdShortTextLabel: UILabel!
    @IBOutlet fileprivate weak var nativeAdLongTextLabel: UILabel!
    @IBOutlet fileprivate weak var nativeAdPromotionNameLabel: UILabel!
    @IBOutlet fileprivate weak var nativeAdPromotionUrlLabel: UILabel!
    @IBOutlet fileprivate weak var nativeAdActionButtonTextLabel: UILabel!
    @IBOutlet fileprivate weak var nativeAdImageView: UIImageView!
    @IBOutlet fileprivate weak var nativeAdLogoImageView: UIImageView!
    
    internal var index: Int = 0
    fileprivate var direction: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.nativeAdPromotionNameLabel.adjustsFontSizeToFitWidth = true
        self.nativeAdPromotionNameLabel.minimumScaleFactor = 0.5
        self.nativeAdPrTextLabel.adjustsFontSizeToFitWidth = true
        self.nativeAdPrTextLabel.baselineAdjustment = .alignCenters
        self.nativeAdLongTextLabel.adjustsFontSizeToFitWidth = true
        self.nativeAdLongTextLabel.minimumScaleFactor = 0.5
        self.nativeAdShortTextLabel.adjustsFontSizeToFitWidth = true
        self.nativeAdShortTextLabel.minimumScaleFactor = 0.5
        self.nativeAdPromotionUrlLabel.adjustsFontSizeToFitWidth = true
        self.nativeAdPromotionUrlLabel.minimumScaleFactor = 0.5
        self.nativeAdActionButtonTextLabel.adjustsFontSizeToFitWidth = true
        self.nativeAdActionButtonTextLabel.minimumScaleFactor = 0.5
        self.nativeAdActionButtonTextLabel.layer.borderColor = UIColor.blue.cgColor
        self.nativeAdActionButtonTextLabel.layer.borderWidth = 1.0
        
        self.layer.borderWidth = 0
        
        if #available(iOS 13, *) {
            self.backgroundColor = UIColor(named: "NativeAdBackgroundColor")
            self.nativeAdPromotionNameLabel.textColor = UIColor(named: "TextColor")
            self.nativeAdPrTextLabel.textColor = UIColor(named: "TextColor")
            self.nativeAdLongTextLabel.textColor = UIColor(named: "TextColor")
            self.nativeAdShortTextLabel.textColor = UIColor(named: "TextColor")
            self.nativeAdPromotionUrlLabel.textColor = UIColor(named: "TextColor")
        }
    }
    
    func frameUpdate(_ direction: Int) {
        self.direction = direction
        self.layoutSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if self.direction == 1 {
            self.frame = CGRect(x: CGFloat(self.index) * adPortraitWidth, y: 0, width: adPortraitWidth, height: adPortraitHeight)
        } else if self.direction == 2 {
            let cellWidth: CGFloat = UIScreen.main.bounds.size.width
            if cellWidth < adLandscapeWidth {
                // iphone4の場合、横幅設定
                self.frame = CGRect(x: CGFloat(self.index) * (cellWidth - 20.0), y: 0, width: (cellWidth - 20.0), height: adLandscapeHeight)
            } else {
                self.frame = CGRect(x: CGFloat(self.index) * adLandscapeWidth, y: 0, width: adLandscapeWidth, height: adLandscapeHeight)
            }
        }
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
