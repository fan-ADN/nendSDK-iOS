//
//  NativeVideoAdBaseView.m
//  ObjC_Example
//
//  Created by 馬場美沙都 on 2023/05/09.
//  Copyright © 2023 F@N Communications. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <NendAd/NendAd.h>

@interface NativeVideoAdBaseView : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *userRatingLabel;
@property (weak, nonatomic) IBOutlet UILabel *userRatingCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UIButton *ctaButton;
@property (weak, nonatomic) IBOutlet NADNativeVideoView *videoAdView;
@property (weak, nonatomic) IBOutlet UILabel *advertiserLabel;

- (void)setTitle:(NSString*) title;
- (void)setDescription:(NSString*) description;
- (void)setUserRating:(NSString*) rating;
- (void)setUserRatingCount:(NSString*) ratingCount;
- (void)setLogo:(UIImage*) logoImage;
- (void)setCtaButtonLabel:(NSString*) buttonText;
- (void)setVideoAd:(NADNativeVideo*) videoAd;
- (void)setAdvertiser:(NSString*) advertiser;

+ (NativeVideoAdBaseView*) loadPortraitXib;
+ (NativeVideoAdBaseView*) loadLandscapeXib;
@end
