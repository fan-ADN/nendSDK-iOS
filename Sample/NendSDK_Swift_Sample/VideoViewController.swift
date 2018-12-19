//
//  VideoViewController.swift
//  NendSDK_Sample
//
//  Created by F@N Communications on 2017/07/18.
//  Copyright © 2017年 F@N Communications. All rights reserved.
//

// このサンプルは広告配信に位置情報をオプションで利用しています。
// This sample uses location data as an option for ad supply.

import UIKit
import CoreLocation
import NendAd

class VideoViewController: UIViewController {
    
    private let rewardedVideo = NADRewardedVideo(spotId: "802555", apiKey: "ca80ed7018734d16787dbda24c9edd26c84c15b8")
    private let interstitialVideo = NADInterstitialVideo(spotId: "802557", apiKey: "b6a97b05dd088b67f68fe6f155fb3091f302b48b")
    private let locationManager = CLLocationManager.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        
        self.rewardedVideo.userId = "user id"
        self.rewardedVideo.delegate = self
        
        self.interstitialVideo.userId = "user id"
        self.interstitialVideo.isLocationEnabled = false
        self.interstitialVideo.isMuteStartPlaying = false
        self.interstitialVideo.delegate = self
        self.interstitialVideo.addFallbackFullboard(withSpotId: "485504", apiKey: "30fda4b3386e793a14b27bedb4dcd29f03d638e5")
    }
    
    @IBAction func loadReward(_ sender: Any) {
        self.rewardedVideo.loadAd()
    }
    
    @IBAction func loadInterstitial(_ sender: Any) {
        self.interstitialVideo.loadAd()
    }
    
    @IBAction func showReward(_ sender: Any) {
        if self.rewardedVideo.isReady {
            self.rewardedVideo.showAd(from: self)
        }
    }
    
    @IBAction func showInterstitial(_ sender: Any) {
        if self.interstitialVideo.isReady {
            self.interstitialVideo.showAd(from: self)
        }
    }
    
    @IBAction func releaseReward(_ sender: Any) {
        self.rewardedVideo.releaseAd()
    }
    
    @IBAction func releaseInterstitial(_ sender: Any) {
        self.interstitialVideo.releaseAd()
    }
}

extension VideoViewController : NADRewardedVideoDelegate {
    func nadRewardVideoAd(_ nadRewardedVideoAd: NADRewardedVideo!, didReward reward: NADReward!)
    {
        print(#function + " " + reward.name! + ": \(reward.amount)")
    }
    
    func nadRewardVideoAdDidReceiveAd(_ nadRewardedVideoAd: NADRewardedVideo!)
    {
        print(#function)
    }
    
    func nadRewardVideoAd(_ nadRewardedVideoAd: NADRewardedVideo!, didFailToLoadWithError error: Error!)
    {
        print(#function + " error: \(String(describing: error!))")
    }
    
    func nadRewardVideoAdDidFailed(toPlay nadRewardedVideoAd: NADRewardedVideo!)
    {
        print(#function)
    }
    
    func nadRewardVideoAdDidOpen(_ nadRewardedVideoAd: NADRewardedVideo!)
    {
        print(#function)
    }
    
    func nadRewardVideoAdDidClose(_ nadRewardedVideoAd: NADRewardedVideo!)
    {
        print(#function)
    }
    
    func nadRewardVideoAdDidStartPlaying(_ nadRewardedVideoAd: NADRewardedVideo!)
    {
        print(#function)
    }
    
    func nadRewardVideoAdDidStopPlaying(_ nadRewardedVideoAd: NADRewardedVideo!)
    {
        print(#function)
    }
    
    func nadRewardVideoAdDidCompletePlaying(_ nadRewardedVideoAd: NADRewardedVideo!)
    {
        print(#function)
    }
    
    func nadRewardVideoAdDidClickAd(_ nadRewardedVideoAd: NADRewardedVideo!)
    {
        print(#function)
    }
    
    func nadRewardVideoAdDidClickInformation(_ nadRewardedVideoAd: NADRewardedVideo!)
    {
        print(#function)
    }
}

extension VideoViewController : NADInterstitialVideoDelegate {
    func nadInterstitialVideoAdDidReceiveAd(_ nadInterstitialVideoAd: NADInterstitialVideo!)
    {
        print(#function)
    }
    
    func nadInterstitialVideoAd(_ nadInterstitialVideoAd: NADInterstitialVideo!, didFailToLoadWithError error: Error!)
    {
        print(#function + " error: \(String(describing: error!))")
    }
    
    func nadInterstitialVideoAdDidFailed(toPlay nadInterstitialVideoAd: NADInterstitialVideo!)
    {
        print(#function)
    }
    
    func nadInterstitialVideoAdDidOpen(_ nadInterstitialVideoAd: NADInterstitialVideo!)
    {
        print(#function)
    }
    
    func nadInterstitialVideoAdDidClose(_ nadInterstitialVideoAd: NADInterstitialVideo!)
    {
        print(#function)
    }
    
    func nadInterstitialVideoAdDidStartPlaying(_ nadInterstitialVideoAd: NADInterstitialVideo!)
    {
        print(#function)
    }
    
    func nadInterstitialVideoAdDidStopPlaying(_ nadInterstitialVideoAd: NADInterstitialVideo!)
    {
        print(#function)
    }
    
    func nadInterstitialVideoAdDidCompletePlaying(_ nadInterstitialVideoAd: NADInterstitialVideo!)
    {
        print(#function)
    }
    
    func nadInterstitialVideoAdDidClickAd(_ nadInterstitialVideoAd: NADInterstitialVideo!)
    {
        print(#function)
    }
    
    func nadInterstitialVideoAdDidClickInformation(_ nadInterstitialVideoAd: NADInterstitialVideo!)
    {
        print(#function)
    }
}

