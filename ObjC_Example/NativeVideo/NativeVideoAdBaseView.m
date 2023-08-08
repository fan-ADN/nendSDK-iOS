//
//  NativeVideoAdBaseView.m
//  ObjC_Example
//
//  Copyright © 2023 F@N Communications. All rights reserved.
//
#import "NativeVideoAdBaseView.h"

@implementation NativeVideoAdBaseView

- (void)setAdvertiser:(NSString *)advertiser
{
    self.advertiserLabel.text = advertiser;
}

- (void)setDescription:(NSString *)description
{
    self.descriptionLabel.text = description;
}

- (void)setLogo:(UIImage *)logoImage
{
    self.logoImageView.image = logoImage;
}

- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

- (void)setUserRating:(NSString *)rating
{
    self.userRatingLabel.text = rating;
}

- (void)setVideoAd:(NADNativeVideo *)videoAd
{
    self.videoAdView.videoAd = videoAd;
}

- (void)setCtaButtonLabel:(NSString *)buttonText
{
    [self.ctaButton setTitle: buttonText forState: UIControlStateNormal];
}

- (void)setUserRatingCount:(NSString *)ratingCount
{
    self.userRatingCountLabel.text = ratingCount;
}

+ (NativeVideoAdBaseView*) loadPortraitXib
{
    UINib *nib =  [UINib nibWithNibName: @"NativeVideoAdPortraitView" bundle:nil];
    NativeVideoAdBaseView *view = [nib instantiateWithOwner: nil options: nil][0];
    return view;
}

+ (NativeVideoAdBaseView*) loadLandscapeXib
{
    UINib *nib =  [UINib nibWithNibName: @"NativeVideoAdLandscapeView" bundle:nil];
    NativeVideoAdBaseView *view = [nib instantiateWithOwner: nil options: nil][0];
    return view;
}

@end
