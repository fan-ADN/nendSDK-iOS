//
//  NativeAdPageContentViewController.swift
//  NendSDK_Sample
//
//  Copyright © 2015年 F@N Communications. All rights reserved.
//

import UIKit
import NendAd

class NativeAdPageContentViewController: UIViewController {
    
    @IBOutlet fileprivate weak var adView: UIView!
    @IBOutlet fileprivate weak var label: UILabel!
    
    var ad: NADNative! {
        didSet {
            self.ad.intoView(self.adView as! (UIView & NADNativeViewRendering)!, advertisingExplicitly: .promotion)
        }
    }
    
    var position: Int! {
        didSet {
            self.label.text = "Page\(self.position!)"
        }
    }
}
