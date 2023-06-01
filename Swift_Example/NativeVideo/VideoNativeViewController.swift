//
//  VideoNativeViewController.swift
//  Swift_Example
//
//  Copyright © 2018年 FAN Communications. All rights reserved.
//

import UIKit
import Foundation
import NendAd

class VideoNativeViewController: UIViewController {
    
    @IBOutlet weak var container: UIView!
    
    private var adView: NativeVideoAdBaseView!
    private var loader: NADNativeVideoLoader!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let isPortrait = checkDeviceOrientation();
        setAdLoader(withOrientation: isPortrait)
        setNativeAd(withOrientation: isPortrait)
        loadNativeVideoAd()
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        let isPortrait = checkDeviceOrientation();
        setAdLoader(withOrientation: isPortrait)
        setNativeAd(withOrientation: isPortrait)
        loadNativeVideoAd()
    }
    
    private func checkDeviceOrientation() -> Bool {
        let orientation = UIDevice.current.orientation
        var isPortrait = orientation.isPortrait
        let isLandscape = orientation.isLandscape
        
        if !isLandscape && !isPortrait {
            isPortrait = UIScreen.main.bounds.width < UIScreen.main.bounds.height;
        }
        return isPortrait
    }
    
    private func setNativeAd(withOrientation isPortrait: Bool){
        if(adView != nil) {
            adView = nil
        }
        
        if (isPortrait) {
            adView = NativeVideoAdBaseView.loadPortraitXib()
        } else {
            adView = NativeVideoAdBaseView.loadLandscapeXib()
        }
        adView.frame = self.container.bounds
        self.container.addSubview(adView)
    }
    
    private func setAdLoader(withOrientation isPortrait: Bool) {
        if(isPortrait) {
            loader = NADNativeVideoLoader(spotID: AdSpaces.videoNativeAdPortraitSpotId, apiKey: AdSpaces.videoNativeAdPortraitApiKey, clickAction: .fullScreen)
        } else {
            loader = NADNativeVideoLoader(spotID: AdSpaces.videoNativeAdLandscapeSpotId, apiKey: AdSpaces.videoNativeAdLandscapeApiKey, clickAction: .fullScreen)
        }
    }
    
    private func loadNativeVideoAd() {
        // Do any additional setup after loading the view.
        
        loader.setFillerStaticNativeAdID(485500, apiKey: "10d9088b5bd36cf43b295b0774e5dcf7d20a4071")
        
        // Enable this line if your Interface Builder does not configure rootViewController property.
        //adView.videoAdView.rootViewController = self
                
        // load ads
        loader.loadAd { [weak self] (ad, error) in
            guard let `self` = self else { return }
            if let videoAd = ad {
                if videoAd.hasVideo {
                    videoAd.delegate = self
                    self.adView.videoAdView.delegate = self
                        
                    self.adView.setTitle("title:\n\(videoAd.title ?? "null")")
                    self.adView.setDescription("description:\n \(videoAd.explanation ?? "null")")
                    self.adView.setAdvertiser("advertiserName:\n\(videoAd.advertiserName ?? "null")")
                        
                    if videoAd.userRating != -1.0 && videoAd.userRatingCount != -1 {
                        self.adView.setUserRating("userRating:\n\(videoAd.userRating)")
                        self.adView.setUserRatingCount("userRatingCount:\n\(videoAd.userRatingCount)")
                    }
                    if let logoImage = videoAd.logoImage {
                        self.adView.setLogo(logoImage)
                    } else {
                        videoAd.downloadLogoImage { image in
                            if let logoImage = image { self.adView.setLogo(logoImage) }
                        }
                    }
                    self.adView.setCtaButton(videoAd.callToAction)
                    videoAd.registerInteractionViews([self.adView.ctaButton])
                    
                    videoAd.isMutedOnFullScreen = true
                    self.adView.setVideoAd(videoAd)
                } else if let staticNativeAd = videoAd.staticNativeAd {
                    print("nativeAd: \(staticNativeAd)")
                    // display native ads...
                }
            } else {
                print("error: \(error!)")
            }
        }
        
    }
}

// MARK: - NADNativeVideoDelegate

extension VideoNativeViewController: NADNativeVideoDelegate {
    
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

// MARK: - NADNativeVideoViewDelegate

extension VideoNativeViewController: NADNativeVideoViewDelegate {
    
    func nadNativeVideoViewDidStartPlay(_ videoView: NADNativeVideoView) {
        print("\(#function)")
    }
    
    func nadNativeVideoViewDidStopPlay(_ videoView: NADNativeVideoView) {
        print("\(#function)")
    }
    
    func nadNativeVideoViewDidCompletePlay(_ videoView: NADNativeVideoView) {
        print("\(#function)")
    }
    
    func nadNativeVideoViewDidFail(toPlay videoView: NADNativeVideoView) {
        print("\(#function)")
    }
    
    func nadNativeVideoViewDidOpenFullScreen(_ videoView: NADNativeVideoView) {
        print("\(#function)")
    }
    
    func nadNativeVideoViewDidCloseFullScreen(_ videoView: NADNativeVideoView) {
        print("\(#function)")
    }
    
    func nadNativeVideoViewDidStartFullScreenPlaying(_ videoView: NADNativeVideoView) {
        print("\(#function)")
    }
    
    func nadNativeVideoViewDidStopFullScreenPlaying(_ videoView: NADNativeVideoView) {
        print("\(#function)")
    }

}
