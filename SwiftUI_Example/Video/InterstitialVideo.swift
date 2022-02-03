//
//  InterstitialVideo.swift
//  SwiftUI_Example
//
//  Copyright © 2022 F@N Communications. All rights reserved.
//

import SwiftUI
import NendAd

struct InterstitialVideo: View {
    
    private let videoDelegate = InterstitialVideoDelegate()
    let interstitialVideo = NADInterstitialVideo(spotID: 802557, apiKey: "b6a97b05dd088b67f68fe6f155fb3091f302b48b")
    
    var body: some View {
        VStack {
            Group{
                Text("Interstitial")
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
    
    init() {
        interstitialVideo.delegate = videoDelegate
    }
    
    func LoadTapped(){
        self.interstitialVideo.loadAd()
    }
    
    
    func ShowTapped(){
        if self.interstitialVideo.isReady {
            self.interstitialVideo.showAd(from: getFrontViewController()!)
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

class InterstitialVideoDelegate: NSObject, NADInterstitialVideoDelegate{
    
    func nadInterstitialVideoAdDidReceiveAd(_ nadInterstitialVideoAd: NADInterstitialVideo!) {
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
    
    func nadInterstitialVideoAd(_ nadInterstitialVideoAd: NADInterstitialVideo!, didFailToLoadWithError error: Error!){
        print("Interstitial Video Did Fail to Receive. error: \(error!)")
    }
    
    func nadInterstitialVideoAdDidFailed(toPlay nadInterstitialVideoAd: NADInterstitialVideo!){
        print("Interstitial Video Did Fail to Show.")
    }
    
    func nadInterstitialVideoAdDidOpen(_ nadInterstitialVideoAd: NADInterstitialVideo!){
        print("Interstitial Video Did Open.")
    }
    
    func nadInterstitialVideoAdDidStartPlaying(_ nadInterstitialVideoAd: NADInterstitialVideo!){
        print("Interstitial Video Did Start Playing.")
    }
    
    func nadInterstitialVideoAdDidStopPlaying(_ nadInterstitialVideoAd: NADInterstitialVideo!){
        print("Interstitial Video Did Stop Playing.")
    }
    
    func nadInterstitialVideoAdDidCompletePlaying(_ nadInterstitialVideoAd: NADInterstitialVideo!){
        print("Interstitial Video Did Complete Playing.")
    }
    
    func nadInterstitialVideoAdDidClose(_ nadInterstitialVideoAd: NADInterstitialVideo!){
        print("Interstitial Video Did Close.")
    }
    
    func nadInterstitialVideoAdDidClickAd(_ nadInterstitialVideoAd: NADInterstitialVideo!){
        print("Interstitial Video Did Click Ad.")
    }
    
    func nadInterstitialVideoAdDidClickInformation(_ nadInterstitialVideoAd: NADInterstitialVideo!){
        print("Interstitial Video Did Click Information.")
    }
}

struct InterstitialVideo_Previews: PreviewProvider {
    static var previews: some View {
        InterstitialVideo()
    }
}
