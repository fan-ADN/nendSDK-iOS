//
//  FullBoardAdWebViewController.swift
//  NendSDK_Sample
//
//  Copyright © 2017年 F@N Communications. All rights reserved.
//

import UIKit
import NendAd

class FullBoardAdWebViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    private let loader = NADFullBoardLoader(spotId: "485504", apiKey: "30fda4b3386e793a14b27bedb4dcd29f03d638e5")
    fileprivate var ad: NADFullBoard?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.webView.scrollView.delegate = self
        self.webView.loadRequest(URLRequest(url: URL(string: "https://www.nend.net")!))
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
