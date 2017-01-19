//
//  NativeAdCellView.swift
//  NendSDK_Sample
//
//  Copyright © 2015年 F@N Communications. All rights reserved.
//

import UIKit
import NendAd

class NativeAdCellView: UITableViewCell, NADNativeViewRendering {

    @IBOutlet fileprivate weak var nativeAdPrTextLabel: UILabel!
    @IBOutlet fileprivate weak var nativeAdLongTextLabel: UILabel!
    @IBOutlet fileprivate weak var nativeAdActionButtonTextLabel: UILabel!
    @IBOutlet fileprivate weak var nativeAdImageView: UIImageView!
    
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
