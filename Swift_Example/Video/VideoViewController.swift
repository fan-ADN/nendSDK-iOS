//
//  VideoViewController.swift
//  ObjC_Example
//
//  Copyright © 2017年 FAN Communications. All rights reserved.
//

import UIKit
import NendAd

class VideoViewController: UIViewController {
    
    private let rewardedVideo = NADRewardedVideo(spotID: 802555, apiKey: "ca80ed7018734d16787dbda24c9edd26c84c15b8")
    private let interstitialVideo = NADInterstitialVideo(spotID: 802557, apiKey: "b6a97b05dd088b67f68fe6f155fb3091f302b48b")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rewardedVideo.delegate = self
        
        self.interstitialVideo.isMuteStartPlaying = false
        self.interstitialVideo.delegate = self
        self.interstitialVideo.addFallbackFullboard(withSpotID: 485504, apiKey: "30fda4b3386e793a14b27bedb4dcd29f03d638e5")
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
        var adType: String
        switch nadRewardedVideoAd.adType {
        case .normal:
            adType = "normal"
        case .playable:
            adType = "playable"
        default:
            adType = "unknown"
        }
        print(#function + " : Ad Type = " + adType)
    }
    
    func nadRewardVideoAd(_ nadRewardedVideoAd: NADRewardedVideo!, didFailToLoadWithError error: Error!)
    {
        print(#function + " error: \(error!)")
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
        var adType: String
        switch nadInterstitialVideoAd.adType {
        case .normal:
            adType = "normal"
        case .playable:
            adType = "playable"
        default:
            adType = "unknown"
        }
        print(#function + " : Ad Type = " + adType)
    }
    
    func nadInterstitialVideoAd(_ nadInterstitialVideoAd: NADInterstitialVideo!, didFailToLoadWithError error: Error!)
    {
        print(#function + " error: \(error!)")
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

