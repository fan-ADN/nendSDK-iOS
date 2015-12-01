//
//  FeedAdCell.swift
//  NendSDK_Sample
//
//  Copyright © 2015年 F@N Communications. All rights reserved.
//

import UIKit

class FeedAdCell: UITableViewCell, NADNativeViewRendering {

    @IBOutlet private weak var nativeAdPrTextLabel: NADNativeLabel!
    @IBOutlet private weak var nativeAdLongTextLabel: NADNativeLabel!
    @IBOutlet private weak var nativeAdActionButtonTextLabel: NADNativeLabel!
    
    // MARK: - NADNativeViewRendering
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.nativeAdActionButtonTextLabel.layer.borderColor = self.nativeAdActionButtonTextLabel.textColor.CGColor;
        self.nativeAdActionButtonTextLabel.layer.borderWidth = 1;
        self.nativeAdActionButtonTextLabel.layer.masksToBounds = true;
        self.nativeAdActionButtonTextLabel.layer.cornerRadius = 0;
    }
    
    // MARK: - NADNativeViewRendering
    
    func prTextLabel() -> NADNativeLabel! {
        return self.nativeAdPrTextLabel
    }
    
    func longTextLabel() -> NADNativeLabel! {
        return self.nativeAdLongTextLabel
    }
    
    func actionButtonTextLabel() -> NADNativeLabel! {
        return self.nativeAdActionButtonTextLabel
    }
}
