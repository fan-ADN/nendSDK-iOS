//
//  NativeAdCellView.swift
//  NendSDK_Sample
//
//  Copyright © 2015年 F@N Communications. All rights reserved.
//

import UIKit

class NativeAdCellView: UITableViewCell, NADNativeViewRendering {

    @IBOutlet private weak var nativeAdPrTextLabel: NADNativeLabel!
    @IBOutlet private weak var nativeAdLongTextLabel: NADNativeLabel!
    @IBOutlet private weak var nativeAdActionButtonTextLabel: NADNativeLabel!
    @IBOutlet private weak var nativeAdImageView: NADNativeImageView!
    
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
    
    func adImageView() -> NADNativeImageView! {
        return self.nativeAdImageView
    }
}
