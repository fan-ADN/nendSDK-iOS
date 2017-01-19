//
//  FullBoardAdViewController.swift
//  NendSDK_Sample
//
//  Created by user on 2017/01/18.
//  Copyright © 2017年 F@N Communications. All rights reserved.
//

import UIKit
import NendAd

class FullBoardAdViewController: UIViewController ,NADFullBoardDelegate {
    
    private var adLoader: NADFullBoardLoader!
    private var ad: NADFullBoard?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.adLoader = NADFullBoardLoader(spotId: "485504", apiKey: "30fda4b3386e793a14b27bedb4dcd29f03d638e5")
    }
    
    @IBAction func loadFullBoardAd() {
        self.adLoader.loadAd { [weak self] (ad: NADFullBoard?, error: NADFullBoardLoaderError) in
            guard let `self` = self else {
                return
            }
            if let fullBoardAd = ad {
                fullBoardAd.delegate = self
                self.ad = fullBoardAd

            } else {
                switch (error) {
                case .failedAdRequest:
                    print("広告リクエストに失敗しました。")
                    break
                case .failedDownloadImage:
                    print("広告画像のダウンロードに失敗しました。")
                    break
                case .invalidAdSpaces:
                    print("フルボード広告で利用できない広告枠が指定されました。")
                    break
                default:
                    break
                }
            }
        }
    }
    
    @IBAction func showFullBoardAd() {
        if let ad = self.ad {
            ad.show(from: self)
        }
    }
    
    // MARK: - NADFullBoardDelegate
    
    func nadFullBoardDidShowAd(_ ad: NADFullBoard!) {
        print(#function)
    }
    
    func nadFullBoardDidClickAd(_ ad: NADFullBoard!) {
        print(#function)
    }
    
    func nadFullBoardDidDismissAd(_ ad: NADFullBoard!) {
        print(#function)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
