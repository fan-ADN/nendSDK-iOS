//
//  NativeView.swift
//  SwiftUI_Example
//
//  Copyright © 2021 FAN Communications. All rights reserved.
//

import SwiftUI
import NendAd

struct NativeView: View {
    
    @ObservedObject var viewModel: ExternalModel = ExternalModel()
    
    var body: some View {
        VStack{
            Group{
                Spacer()
                Text(self.viewModel.prText)
                    .frame(maxWidth: .infinity,maxHeight:50,alignment: .leading)
                Text(self.viewModel.shortText)
                    .frame(maxWidth: .infinity,maxHeight:50,alignment: .leading)
                Text(self.viewModel.longText)
                    .frame(maxWidth: .infinity,maxHeight:50,alignment: .leading)
                Image(uiImage: self.viewModel.adImage)
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
    @Published var prText:String = ""
    @Published var shortText:String = ""
    @Published var longText:String = ""
    @Published var adImage:UIImage = UIImage()
    let nativeDelegate = NativeDelegate()
    let client = NADNativeClient(spotID: 485504, apiKey: "30fda4b3386e793a14b27bedb4dcd29f03d638e5")
    
    func LoadAd(){
        self.client!.load() { (ad, error) in
            if let nativeAd = ad {
                // success
                nativeAd.delegate = self.nativeDelegate
                self.prText = "PR : " + nativeAd.prText(for: .PR)
                self.shortText = "Short : " + nativeAd.shortText
                self.longText = "Long : " + nativeAd.longText
                nativeAd.loadAdImage { image in
                    self.adImage = image!
                }
            } else {
                // failure
            }
        }
    }
}

class NativeDelegate: NSObject, NADNativeDelegate{
    // 広告がクリックされた時に呼び出されます
    func nadNativeDidClickAd(_ ad: NADNative!) {
        print("Click ad.")
    }
}

struct NativeView_Previews: PreviewProvider {
    static var previews: some View {
        NativeView()
    }
}
