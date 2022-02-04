//
//  NativeVideoView.swift
//  SwiftUI_Example
//
//  Copyright © 2022 FAN Communications. All rights reserved.
//

import SwiftUI
import NendAd

struct NativeVideoView: View {
    
    var body: some View {
        VStack {
            Group{
                NativeVideoAdWrapper()
            }
        }
    }
    
    struct NativeVideoAdWrapper : UIViewRepresentable {
        
        func makeUIView(context: Context) -> some AdView {
            return AdView()
        }
        
        func updateUIView(_ uiView: UIViewType, context: Context) {
        }
    }
}

class AdView: UIView, ObservableObject {
    
    var videoView : NADNativeVideoView!
    let nativeVideoDelegate = NativeVideoDelegate()
    let videoAdLoader = NADNativeVideoLoader(spotID: 887595, apiKey: "e7c1e68e7c16e94270bf39719b60534596b1e70d", clickAction: .fullScreen)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        videoView = NADNativeVideoView(rootViewController: getFrontViewController()!)
        videoAdLoader.loadAd { (ad, error) in
            if let videoAd = ad {
                videoAd.delegate = self.nativeVideoDelegate
                self.videoView.videoAd = videoAd
                self.addSubview(self.videoView)
            } else {
                // failure
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

//class ExternalModel: ObservableObject{
//    @Published var title:String = ""
//    @Published var explanation:String = ""
//    @Published var advertiserName:String = ""
//
//    let nativeVideoDelegate = NativeVideoDelegate()
//    let videoAdLoader = NADNativeVideoLoader(spotID: 887595, apiKey: "e7c1e68e7c16e94270bf39719b60534596b1e70d", clickAction: .fullScreen)
//
//    func LoadAd(){
//        videoAdLoader.loadAd { (ad, error) in
//            if let videoAd = ad {
//                // success
//                videoAd.delegate = self.nativeVideoDelegate
//                self.title = "Title : " + videoAd.title!
//                self.explanation = "Explanation : " + videoAd.explanation!
//                self.advertiserName = "AdvertiserName : " + videoAd.advertiserName!
//            } else {
//                // failure
//            }
//        }
//    }
//}

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
