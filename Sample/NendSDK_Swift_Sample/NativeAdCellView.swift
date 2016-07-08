//
//  NativeAdCellView.swift
//  NendSDK_Sample
//
//  Copyright © 2015年 F@N Communications. All rights reserved.
//

import UIKit

class NativeAdCellView: UITableViewCell, NADNativeViewRendering {

    @IBOutlet private weak var nativeAdPrTextLabel: UILabel!
    @IBOutlet private weak var nativeAdLongTextLabel: UILabel!
    @IBOutlet private weak var nativeAdActionButtonTextLabel: UILabel!
    @IBOutlet private weak var nativeAdImageView: UIImageView!
    
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
    
    func adImageView() -> UIImageView! {
        return self.nativeAdImageView
    }
}
