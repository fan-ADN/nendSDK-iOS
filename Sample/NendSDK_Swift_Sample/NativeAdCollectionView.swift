//
//  NativeAdCollectionView.swift
//  NendSDK_Sample
//
//  Copyright © 2015年 F@N Communications. All rights reserved.
//

import UIKit
import NendAd

class NativeAdCollectionView: UICollectionViewCell, NADNativeViewRendering {
 
    @IBOutlet fileprivate weak var nativeAdPrTextLabel: UILabel!
    @IBOutlet fileprivate weak var nativeAdShortTextLabel: UILabel!
    @IBOutlet fileprivate weak var nativeAdImageView: UIImageView!
    
    // MARK: - NADNativeViewRendering
    
    func prTextLabel() -> UILabel! {
        return self.nativeAdPrTextLabel
    }
    
    func shortTextLabel() -> UILabel! {
        return self.nativeAdShortTextLabel
    }
    
    func adImageView() -> UIImageView! {
        return self.nativeAdImageView
    }    
}
