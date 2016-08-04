//
//  NativeAdCarouselView.swift
//  NendSDK_Sample
//
//  Copyright © 2016年 F@N Communications. All rights reserved.
//

import UIKit

class NativeAdCarouselView: UIView, NADNativeViewRendering {
    
    @IBOutlet private weak var nativeAdPrTextLabel: UILabel!
    @IBOutlet private weak var nativeAdShortTextLabel: UILabel!
    @IBOutlet private weak var nativeAdLongTextLabel: UILabel!
    @IBOutlet private weak var nativeAdPromotionNameLabel: UILabel!
    @IBOutlet private weak var nativeAdPromotionUrlLabel: UILabel!
    @IBOutlet private weak var nativeAdActionButtonTextLabel: UILabel!
    @IBOutlet private weak var nativeAdImageView: UIImageView!
    @IBOutlet private weak var nativeAdLogoImageView: UIImageView!
    
    internal var index: Int = 0
    private var direction: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.nativeAdPromotionNameLabel.adjustsFontSizeToFitWidth = true
        self.nativeAdPromotionNameLabel.minimumScaleFactor = 0.5
        self.nativeAdPrTextLabel.adjustsFontSizeToFitWidth = true
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
