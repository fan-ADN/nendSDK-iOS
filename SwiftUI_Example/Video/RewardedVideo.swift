//
//  RewardedVideo.swift
//  SwiftUI_Example
//
//  Copyright © 2022 F@N Communications. All rights reserved.
//

import SwiftUI
import NendAd

struct RewardedVideo: View {
    
    private let videoDelegate = RewardedVideoDelegate()
    let rewardedVideo = NADRewardedVideo(spotID: 802555, apiKey: "ca80ed7018734d16787dbda24c9edd26c84c15b8")
    
    var body: some View {
        VStack {
            Group{
                Text("Reward")
                Spacer()
                //Loadボタン
                Button(action: {
                    LoadTapped()
                }) {
                    Text("Load")
                }
                Spacer()
                //Showボタン
                Button(action: {
                    ShowTapped()
                }) {
                    Text("Show")
                }
                Spacer()
            }
        }
    }
    
    func LoadTapped(){
        rewardedVideo.delegate = videoDelegate
        self.rewardedVideo.loadAd()
    }
    
    func ShowTapped(){
        if self.rewardedVideo.isReady {
            self.rewardedVideo.showAd(from: getFrontViewController()!)
        }
    }
    
    func getFrontViewController() -> UIViewController? {
        let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        
        let vc = keyWindow?.rootViewController
        guard let _vc = vc?.presentedViewController else {
            return vc
        }
        return _vc
    }
}

class RewardedVideoDelegate: NSObject, NADRewardedVideoDelegate{
    
    func nadRewardVideoAd(_ nadRewardedVideoAd: NADRewardedVideo!, didReward reward: NADReward!){
        print("Rewarded. Currency name: " + reward.name! + ", Currency amount: \(reward.amount)")
    }
    
    func nadRewardVideoAdDidReceiveAd(_ nadRewardedVideoAd: NADRewardedVideo!) {
        var adType: String
        switch nadRewardedVideoAd.adType {
        case .normal:
            adType = "normal"
            break
        case .playable:
            adType = "playable"
            break
        default:
            adType = "unknown"
            break
        }
        print(#function + " : Ad Type = " + adType)
    }
    
    func nadRewardVideoAd(_ nadRewardedVideoAd: NADRewardedVideo!, didFailToLoadWithError error: Error!) {
        print("Rewarded Video Did Fail to Receive. error: \(error!)")
    }
    
    func nadRewardVideoAdDidFailed(toPlay nadRewardedVideoAd: NADRewardedVideo!) {
        print("Rewarded Video Did Fail to Show.")
    }
    
    func nadRewardVideoAdDidOpen(_ nadRewardedVideoAd: NADRewardedVideo!) {
        print("Rewarded Video Did Open.")
    }
    
    func nadRewardVideoAdDidStartPlaying(_ nadRewardedVideoAd: NADRewardedVideo!) {
        print("Rewarded Video Did Start Playing.")
    }
    
    func nadRewardVideoAdDidStopPlaying(_ nadRewardedVideoAd: NADRewardedVideo!) {
        print("Rewarded Video Did Stop Playing.")
    }
    
    func nadRewardVideoAdDidCompletePlaying(_ nadRewardedVideoAd: NADRewardedVideo!) {
        print("Rewarded Video Did Complete Playing.")
    }
    
    func nadRewardVideoAdDidClose(_ nadRewardedVideoAd: NADRewardedVideo!) {
        print("Rewarded Video Did Close.")
    }
    
    func nadRewardVideoAdDidClickAd(_ nadRewardedVideoAd: NADRewardedVideo!) {
        print("Rewarded Video Did Click Ad.")
    }
    
    func nadRewardVideoAdDidClickInformation(_ nadRewardedVideoAd: NADRewardedVideo!) {
        print("Rewarded Video Did Click Information.")
    }
}

struct RewardedVideo_Previews: PreviewProvider {
    static var previews: some View {
        RewardedVideo()
    }
}
