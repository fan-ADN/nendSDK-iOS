//
//  NativeAdCollectionView.swift
//  NendSDK_Sample
//
//  Copyright © 2015年 F@N Communications. All rights reserved.
//

import UIKit

class NativeAdCollectionView: UICollectionViewCell, NADNativeViewRendering {
 
    @IBOutlet private weak var nativeAdPrTextLabel: UILabel!
    @IBOutlet private weak var nativeAdShortTextLabel: UILabel!
    @IBOutlet private weak var nativeAdImageView: UIImageView!
    
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
