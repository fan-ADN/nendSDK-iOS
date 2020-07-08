//
//  FullBoardAdWebViewController.swift
//  ObjC_Example
//
//  Copyright © 2017年 FAN Communications. All rights reserved.
//

import UIKit
import WebKit
import NendAd

class FullBoardAdWebViewController: UIViewController {

    private var webView: WKWebView!
    private let loader = NADFullBoardLoader(spotID: 485504, apiKey: "30fda4b3386e793a14b27bedb4dcd29f03d638e5")
    fileprivate var ad: NADFullBoard?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.webView = WKWebView(frame: self.view.frame, configuration: WKWebViewConfiguration())
        self.webView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.webView)
        
        view.addConstraints([
            NSLayoutConstraint.init(item: self.webView!,
                                    attribute: .top,
                                    relatedBy: .equal,
                                    toItem: self.view,
                                    attribute: .top,
                                    multiplier: 1,
                                    constant: 0),
            NSLayoutConstraint.init(item: self.webView!,
                                    attribute: .leading,
                                    relatedBy: .equal,
                                    toItem: self.view,
                                    attribute: .leading,
                                    multiplier: 1,
                                    constant: 0),
            NSLayoutConstraint.init(item: self.webView!,
                                    attribute: .trailing,
                                    relatedBy: .equal,
                                    toItem: self.view,
                                    attribute: .trailing,
                                    multiplier: 1,
                                    constant: 0),
            NSLayoutConstraint.init(item: self.webView!,
                                    attribute: .bottom,
                                    relatedBy: .equal,
                                    toItem: self.view,
                                    attribute: .bottom,
                                    multiplier: 1,
                                    constant: 0)
        ])
        
        self.webView.scrollView.delegate = self
        self.webView.load(URLRequest(url: URL(string: "https://www.nend.net")!))
        self.loadAd()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadAd() {
        self.loader!.loadAd(completionHandler: { [weak self] (ad, error) in
            guard let strongSelf = self, let fullboardAd = ad else {
                return
            }
            fullboardAd.delegate = strongSelf
            strongSelf.ad = fullboardAd
        })
    }
}

extension FullBoardAdWebViewController: NADFullBoardDelegate {
    
    func nadFullBoardDidDismissAd(_ ad: NADFullBoard!) {
        self.loadAd()
    }
}

extension FullBoardAdWebViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= scrollView.contentSize.height - scrollView.frame.size.height {
            if let fullboardAd = self.ad {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    fullboardAd.show(from: self)
                }
            }
        }
    }
}
