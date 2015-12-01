//
//  NativeAdPageContentViewController.swift
//  NendSDK_Sample
//
//  Copyright © 2015年 F@N Communications. All rights reserved.
//

import UIKit

class NativeAdPageContentViewController: UIViewController {
    
    @IBOutlet private weak var adView: UIView!
    @IBOutlet private weak var label: UILabel!
    
    var ad: NADNative! {
        didSet {
            self.ad.intoView(self.adView)
        }
    }
    
    var position: Int! {
        didSet {
            self.label.text = "Page\(self.position)"
        }
    }
}