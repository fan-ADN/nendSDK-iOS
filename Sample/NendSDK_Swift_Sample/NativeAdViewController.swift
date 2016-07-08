//
//  NativeAdViewController.swift
//  NendSDK_Sample
//
//  Copyright (c) 2015年 F@N Communications. All rights reserved.
//

import UIKit

class NativeAdViewController: UIViewController, NADNativeDelegate {
    
    private var client: NADNativeClient?

    var spotId: String!
    var apiKey: String!
    var nib: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Simple"
        
        // Xibから広告Viewを生成
        let nib = UINib(nibName: self.nib, bundle: nil)
        if let adView = nib.instantiateWithOwner(nil, options: nil).first as? UIView {
            adView.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds))
            adView.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(adView)
            let constraints = [
                NSLayoutConstraint(item: adView, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1.0, constant: 0.0),
                NSLayoutConstraint(item: adView, attribute: .CenterY, relatedBy: .Equal, toItem: self.view, attribute: .CenterY, multiplier: 1.0, constant: 0.0),
                NSLayoutConstraint(item: adView, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .Width, multiplier: 1.0, constant: CGRectGetWidth(adView.bounds)),
                NSLayoutConstraint(item: adView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1.0, constant: CGRectGetHeight(adView.bounds))
            ]
            self.view.addConstraints(constraints)
            
            NADNativeLogger.setLogLevel(.Warn)
            
            self.client = NADNativeClient(spotId: self.spotId, apiKey: self.apiKey)
            self.client!.loadWithCompletionBlock() { (ad, error) in
                if let nativeAd = ad {
                    nativeAd.delegate = self
                    // 広告をViewに描画
                    nativeAd.intoView(adView, advertisingExplicitly:.PR)
                } else {
                    print("error:\(error)")
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - NADNativeDelegate
    func nadNativeDidClickAd(ad: NADNative!) {
        print(#function)
    }
}