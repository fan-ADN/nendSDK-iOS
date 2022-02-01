//
//  NativeVideoView.swift
//  SwiftUI_Example
//
//  Copyright © 2022 FAN Communications. All rights reserved.
//

import SwiftUI
import NendAd

struct NativeVideoView: View {
    
    let nativeVideoDelegate = NativeVideoDelegate()
    let videoAdLoader = NADNativeVideoLoader(spotID: 887595, apiKey: "e7c1e68e7c16e94270bf39719b60534596b1e70d", clickAction: .fullScreen)
    
    var body: some View {
        VStack {
            Group{
                Spacer()
                Text("Native")
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
    
    func ShowTapped(){
        videoAdLoader.loadAd { (ad, error) in
            if let videoAd = ad {
                // success
                videoAd.delegate = nativeVideoDelegate
            } else {
                // failure
            }
        }
    }
}

class NativeVideoDelegate: NSObject, NADNativeVideoDelegate{
    func nadNativeVideoDidImpression(_ ad: NADNativeVideo) {
        print("\(#function)")
    }
    
    func nadNativeVideoDidClickAd(_ ad: NADNativeVideo) {
        print("\(#function)")
    }
    
    func nadNativeVideoDidClickInformation(_ ad: NADNativeVideo) {
        print("\(#function)")
    }
}

struct NativeVideoView_Previews: PreviewProvider {
    static var previews: some View {
        NativeVideoView()
    }
}
