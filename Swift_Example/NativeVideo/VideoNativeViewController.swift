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

    @IBOutlet private weak var videoView: NADNativeVideoView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var advertiserNameLabel: UILabel!
    @IBOutlet private weak var userRatingLabel: UILabel!
    @IBOutlet private weak var userRatingCountLabel: UILabel!
    @IBOutlet private weak var logoImageView: UIImageView!
    @IBOutlet private weak var callToActionButton: UIButton!

    private let loader = NADNativeVideoLoader(spotID: AdSpaces.videoNativeAdSpotId, apiKey: AdSpaces.videoNativeAdApiKey, clickAction: .fullScreen)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // optional settings
        loader.userId = "guestuser"
        let userFeature = NADUserFeature()
        userFeature.gender = .male
        userFeature.setBirthdayWithYear(2000, month: 1, day: 1)
        loader.userFeature = userFeature
        loader.isLocationEnabled = false
        loader.setFillerStaticNativeAdID(485500, apiKey: "10d9088b5bd36cf43b295b0774e5dcf7d20a4071")
        
        videoView.delegate = self
        // Enable this line if your Interface Builder does not configure rootViewController property.
//        videoView.rootViewController = self
                
        // load ads
        loader.loadAd { [weak self] (ad, error) in
            guard let `self` = self else { return }
            if let videoAd = ad {
                if videoAd.hasVideo {
                    videoAd.delegate = self
                    self.titleLabel.text = "title:\n\(videoAd.title ?? "null")"
                    self.descriptionLabel.text = "description:\n \(videoAd.explanation ?? "null")"
                    self.advertiserNameLabel.text = "advertiserName:\n\(videoAd.advertiserName ?? "null")"
                    if videoAd.userRating != -1.0 && videoAd.userRatingCount != -1 {
                        self.userRatingLabel.text = "userRating:\n\(videoAd.userRating)"
                        self.userRatingCountLabel.text = "userRatingCount:\n\(videoAd.userRatingCount)"
                    }
                    if let logoImage = videoAd.logoImage {
                        self.logoImageView.image = logoImage
                    } else {
                        videoAd.downloadLogoImage { image in
                            if let logoImage = image { self.logoImageView.image = logoImage }
                        }
                    }
                    self.callToActionButton.setTitle(videoAd.callToAction, for: .normal)
                    videoAd.registerInteractionViews([self.callToActionButton])

                    videoAd.isMutedOnFullScreen = true
                    self.videoView.videoAd = videoAd
                } else if let staticNativeAd = videoAd.staticNativeAd {
                    print("nativeAd: \(staticNativeAd)")
                    // display native ads...
                }
            } else {
                print("error: \(error!)")
            }
        }
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
