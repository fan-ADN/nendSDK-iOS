//
//  NativeVideoAdBaseView.swift
//  NendSDK_Sample
//
//  Created by 馬場美沙都 on 2023/04/17.
//  Copyright © 2023 F@N Communications. All rights reserved.
//

import UIKit
import NendAd

class NativeVideoAdBaseView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var userRatingLabel: UILabel!
    @IBOutlet weak var userRatingCountLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var ctaButton: UIButton!
    @IBOutlet weak var videoAdView: NADNativeVideoView!
    @IBOutlet weak var advertiserLabel: UILabel!
    
    static func loadPortraitXib() -> NativeVideoAdBaseView {
        let view = UINib(nibName: "NativeVideoAdPortraitView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! NativeVideoAdBaseView
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return view
    }
    
    static func loadLandscapeXib() -> NativeVideoAdBaseView {
        return UINib(nibName: "NativeVideoAdLandscapeView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! NativeVideoAdBaseView
    }
    
    func setTitle(_ title: String!){
        self.titleLabel.text = title
    }
    
    func setDescription(_ description: String!){
        self.descriptionLabel.text = description
    }
    
    func setUserRating(_ rating: String!){
        self.userRatingLabel.text = rating
    }
    
    func setUserRatingCount(_ ratingCount: String!){
        self.userRatingCountLabel.text = ratingCount
    }
    
    func setLogo(_ logoImage: UIImage) {
        self.logoImageView.image = logoImage
    }
    
    func setCtaButton(_ buttonText: String!){
        self.ctaButton.setTitle(buttonText, for: .normal)
    }
    
    func setVideoAd(_ videoAd: NADNativeVideo) {
        self.videoAdView.videoAd = videoAd
    }
    
    func setAdvertiser(_ advertiser: String!) {
        self.advertiserLabel.text = advertiser
    }
}
