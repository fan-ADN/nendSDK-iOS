//
//  InterstitialView.swift
//  SwiftUI_Example
//
//  Copyright © 2022 FAN Communications. All rights reserved.
//

import SwiftUI
import NendAd

struct InterstitialView: View {
    
    private let interstitialDelegate = InterstitialDelegate()
    
    var body: some View {
        VStack {
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
                showTapped()
            }) {
                Text("Show")
            }
            Spacer()
        }
    }
    
    init() {
        NADInterstitial.sharedInstance().loadingDelegate = interstitialDelegate
        NADInterstitial.sharedInstance().clickDelegate = interstitialDelegate
    }
    
    func LoadTapped() {
        NADInterstitial.sharedInstance().loadAd(withSpotID: 213208, apiKey: "308c2499c75c4a192f03c02b2fcebd16dcb45cc9")
    }
    
    func showTapped() {
        NADInterstitial.sharedInstance().showAd(from:    Util.getFrontViewController())
    }
}

//Delegate
class InterstitialDelegate: NSObject, NADInterstitialLoadingDelegate, NADInterstitialClickDelegate {
    
    func didFinishLoadInterstitialAd(withStatus status: NADInterstitialStatusCode) {
        switch(status){
        case .SUCCESS:
            print("SUCCESS")
            break
        case .INVALID_RESPONSE_TYPE:
            print("INVALID_RESPONSE_TYPE")
            break
        case .FAILED_AD_REQUEST:
            print("FAILED_AD_REQUEST")
            break
        case .FAILED_AD_DOWNLOAD:
            print("FAILED_AD_DOWNLOAD")
            break
        @unknown default:
            break
        }
    }
    
    func didClick(with type: NADInterstitialClickType) {
        switch(type){
        case .DOWNLOAD:
            print("DOWNLOAD")
            break
        case .CLOSE:
            print("CLOSE")
            break
        case .INFORMATION:
            print("INFORMATION")
            break
        @unknown default:
            break
        }
    }
}

struct InterstitialView_Previews: PreviewProvider {
    static var previews: some View {
        InterstitialView()
    }
}
