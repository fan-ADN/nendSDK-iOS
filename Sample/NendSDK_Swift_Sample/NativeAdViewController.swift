//
//  NativeAdViewController.swift
//  NendSDK_Sample
//
//  Copyright (c) 2015年 F@N Communications. All rights reserved.
//

import UIKit
import NendAd

class NativeAdViewController: UIViewController, NADNativeDelegate {
    
    fileprivate var client: NADNativeClient?

    var spotId: String!
    var apiKey: String!
    var nib: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Simple"
        
        // Xibから広告Viewを生成
        let nib = UINib(nibName: self.nib, bundle: nil)
        if let adView = nib.instantiate(withOwner: nil, options: nil).first as? UIView {
            adView.center = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY)
            adView.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(adView)
            let constraints = [
                NSLayoutConstraint(item: adView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0),
                NSLayoutConstraint(item: adView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 0.0),
                NSLayoutConstraint(item: adView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: adView.bounds.width),
                NSLayoutConstraint(item: adView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: adView.bounds.height)
            ]
            self.view.addConstraints(constraints)
            
            NADNativeLogger.setLogLevel(.warn)
            
            self.client = NADNativeClient(spotId: self.spotId, apiKey: self.apiKey)
            self.client!.load() { (ad, error) in
                if let nativeAd = ad {
                    nativeAd.delegate = self
                    // 広告をViewに描画
                    nativeAd.intoView(adView as! UIView & NADNativeViewRendering, advertisingExplicitly:.PR)
                } else {
                    print("error:\(error!)")
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - NADNativeDelegate
    func nadNativeDidClickAd(_ ad: NADNative!) {
        print(#function)
    }
}
