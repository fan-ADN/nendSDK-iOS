//
//  NativeAdCollectionView.swift
//  NendSDK_Sample
//
//  Copyright © 2015年 F@N Communications. All rights reserved.
//

import UIKit

class NativeAdCollectionView: UICollectionViewCell, NADNativeViewRendering {
 
    @IBOutlet private weak var nativeAdPrTextLabel: NADNativeLabel!
    @IBOutlet private weak var nativeAdShortTextLabel: NADNativeLabel!
    @IBOutlet private weak var nativeAdImageView: NADNativeImageView!
    
    // MARK: - NADNativeViewRendering
    
    func prTextLabel() -> NADNativeLabel! {
        return self.nativeAdPrTextLabel
    }
    
    func shortTextLabel() -> NADNativeLabel! {
        return self.nativeAdShortTextLabel
    }
    
    func adImageView() -> NADNativeImageView! {
        return self.nativeAdImageView
    }    
}
