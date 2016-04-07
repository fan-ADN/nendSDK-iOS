//
//  NativeAdCarouselView.swift
//  NendSDK_Sample
//
//  Copyright © 2016年 F@N Communications. All rights reserved.
//

import UIKit

class NativeAdCarouselView: UIView, NADNativeViewRendering {
    
    @IBOutlet private weak var nativeAdPrTextLabel: NADNativeLabel!
    @IBOutlet private weak var nativeAdShortTextLabel: NADNativeLabel!
    @IBOutlet private weak var nativeAdLongTextLabel: NADNativeLabel!
    @IBOutlet private weak var nativeAdPromotionNameLabel: NADNativeLabel!
    @IBOutlet private weak var nativeAdPromotionUrlLabel: NADNativeLabel!
    @IBOutlet private weak var nativeAdActionButtonTextLabel: NADNativeLabel!
    @IBOutlet private weak var nativeAdImageView: NADNativeImageView!
    @IBOutlet private weak var nativeAdLogoImageView: NADNativeImageView!
    
    internal var index: Int = 0
    private var direction: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.nativeAdPromotionNameLabel.adjustsFontSizeToFitWidth = true
        self.nativeAdPromotionNameLabel.minimumScaleFactor = 0.5
        self.nativeAdPrTextLabel.adjustsFontSizeToFitWidth = true
        self.nativeAdPrTextLabel.minimumScaleFactor = 0.5
        self.nativeAdLongTextLabel.adjustsFontSizeToFitWidth = true
        self.nativeAdLongTextLabel.minimumScaleFactor = 0.5
        self.nativeAdShortTextLabel.adjustsFontSizeToFitWidth = true
        self.nativeAdShortTextLabel.minimumScaleFactor = 0.5
        self.nativeAdPromotionUrlLabel.adjustsFontSizeToFitWidth = true
        self.nativeAdPromotionUrlLabel.minimumScaleFactor = 0.5
        self.nativeAdActionButtonTextLabel.adjustsFontSizeToFitWidth = true
        self.nativeAdActionButtonTextLabel.minimumScaleFactor = 0.5
        self.nativeAdActionButtonTextLabel.layer.borderColor = UIColor.blueColor().CGColor
        self.nativeAdActionButtonTextLabel.layer.borderWidth = 1.0
        
        self.layer.borderWidth = 0
    }
    
    func frameUpdate(direction: Int) {
        self.direction = direction
        self.layoutSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if self.direction == 1 {
            self.frame = CGRectMake(CGFloat(self.index) * adPortraitWidth, 0, adPortraitWidth, adPortraitHeight)
        } else if self.direction == 2 {
            let cellWidth: CGFloat = UIScreen.mainScreen().bounds.size.width
            if cellWidth < adLandscapeWidth {
                // iphone4の場合、横幅設定
                self.frame = CGRectMake(CGFloat(self.index) * (cellWidth - 20.0), 0, (cellWidth - 20.0), adLandscapeHeight)
            } else {
                self.frame = CGRectMake(CGFloat(self.index) * adLandscapeWidth, 0, adLandscapeWidth, adLandscapeHeight)
            }
        }
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
