//
//  NativeVideoView.swift
//  SwiftUI_Example
//
//  Copyright © 2022 FAN Communications. All rights reserved.
//

import SwiftUI
import NendAd

struct NativeVideoView: View {
    
    @ObservedObject var viewModel: ExternalModel = ExternalModel()
    
    var body: some View {
        VStack {
            Group{
                Spacer()
                Text(self.viewModel.title)
                    .frame(maxWidth: .infinity,maxHeight:50,alignment: .leading)
                Text(self.viewModel.explanation)
                    .frame(maxWidth: .infinity,maxHeight:50,alignment: .leading)
                Text(self.viewModel.advertiserName)
                    .frame(maxWidth: .infinity,maxHeight:50,alignment: .leading)
                //                Image(self.viewModel.logo)
                Spacer()
                //Showボタン
                Button(action: {
                    self.viewModel.LoadAd()
                }) {
                    Text("Show")
                }
                Spacer()
            }
        }
    }
}

class ExternalModel: ObservableObject{
    @Published var title:String = ""
    @Published var explanation:String = ""
    @Published var advertiserName:String = ""
    //    @Published var logo:Image
    let nativeVideoDelegate = NativeVideoDelegate()
    let videoAdLoader = NADNativeVideoLoader(spotID: 887595, apiKey: "e7c1e68e7c16e94270bf39719b60534596b1e70d", clickAction: .fullScreen)
    
    func LoadAd(){
        videoAdLoader.loadAd { (ad, error) in
            if let videoAd = ad {
                // success
                videoAd.delegate = self.nativeVideoDelegate
                self.title = "Title : " + videoAd.title!
                self.explanation = "Explanation : " + videoAd.explanation!
                self.advertiserName = "AdvertiserName : " + videoAd.advertiserName!
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
