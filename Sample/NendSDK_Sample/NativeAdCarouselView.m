//
//  NativeAdCarouselView.m
//  NendSDK_Sample
//
//  Copyright © 2016年 F@N Communications. All rights reserved.
//

#import "NativeAdCarouselView.h"

@implementation NativeAdCarouselView

//-(void) layoutSubviews {
//    [super layoutSubviews];
//    
//    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
//    switch (orientation) {
//        case UIInterfaceOrientationPortrait:
//        case UIDeviceOrientationPortraitUpsideDown:
//            // 立て向き画面のレイアウト
//            self.frame = CGRectMake(320 * self.index, 0, 320, 325);
//            _nativeAdLogoImageView.frame = CGRectMake(10.f, 10.f, 40.f, 40.f);
//            _nativeAdPromotionNameLabel.frame = CGRectMake(60.f, 10.f, 250.f, 20.f);
//            _nativeAdPrTextLabel.frame = CGRectMake(60.f, 30.f, 40.f, 20.f);
//            _nativeAdLongTextLabel.frame = CGRectMake(10.f, 55.f, 300.f, 30.f);
//            _nativeAdImageView.frame = CGRectMake(10.f, 90.f, 300.f, 180.f);
//            _nativeAdShortTextLabel.frame = CGRectMake(10.f, 275.f, 200.f, 20.f);
//            _nativeAdPromotionUrlLabel.frame = CGRectMake(10.f, 295.f, 180.f, 20.f);
//            _nativeAdActionButtonTextLabel.frame = CGRectMake(190.f, 295.f, 120.f, 20.f);
//            break;
//        case UIDeviceOrientationLandscapeRight:
//        case UIDeviceOrientationLandscapeLeft:
//            // 横向き画面のレイアウト
//            self.frame = CGRectMake(580 * self.index, 0, 580, 200);
//            _nativeAdImageView.frame = CGRectMake(10.f, 10.f, 300.f, 180.f);
//            _nativeAdPromotionNameLabel.frame = CGRectMake(320.f, 10.f, 180.f, 20.f);
//            _nativeAdPrTextLabel.frame = CGRectMake(320.f, 40, 40.f, 20.f);
//            _nativeAdLongTextLabel.frame = CGRectMake(320.f, 65.f, 250.f, 40.f);
//            _nativeAdShortTextLabel.frame = CGRectMake(320.f, 110.f, 250.f, 20.f);
//            _nativeAdPromotionUrlLabel.frame = CGRectMake(320.f, 140.f, 200.f, 20.f);
//            _nativeAdActionButtonTextLabel.frame = CGRectMake(320.f, 170.f, 120.f, 20.f);
//            _nativeAdLogoImageView.frame = CGRectMake(530.f, 150.f, 40.f, 40.f);
//            break;
//        case UIDeviceOrientationUnknown:
//            break;
//    }
//}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _nativeAdPromotionNameLabel.adjustsFontSizeToFitWidth = YES;
        _nativeAdPromotionNameLabel.minimumScaleFactor = 0.5f;
        _nativeAdPrTextLabel.adjustsFontSizeToFitWidth = YES;
        _nativeAdPrTextLabel.minimumScaleFactor = 0.5f;
        _nativeAdLongTextLabel.adjustsFontSizeToFitWidth = YES;
        _nativeAdLongTextLabel.minimumScaleFactor = 0.5f;
        _nativeAdShortTextLabel.adjustsFontSizeToFitWidth = YES;
        _nativeAdShortTextLabel.minimumScaleFactor = 0.5f;
        _nativeAdPromotionUrlLabel.adjustsFontSizeToFitWidth = YES;
        _nativeAdPromotionUrlLabel.minimumScaleFactor = 0.5f;
        _nativeAdActionButtonTextLabel.textColor = [UIColor blueColor];
        _nativeAdActionButtonTextLabel.adjustsFontSizeToFitWidth = YES;
        _nativeAdActionButtonTextLabel.minimumScaleFactor = 0.5f;
        
        [self addSubview:_nativeAdLogoImageView];
        [self addSubview:_nativeAdShortTextLabel];
        [self addSubview:_nativeAdPrTextLabel];
        [self addSubview:_nativeAdLongTextLabel];
        [self addSubview:_nativeAdImageView];
        [self addSubview:_nativeAdPromotionNameLabel];
        [self addSubview:_nativeAdPromotionUrlLabel];
        [self addSubview:_nativeAdActionButtonTextLabel];
        
        self.layer.borderWidth = 0.f;
    }
    return self;
}

#pragma mark - NADNativeViewRendering

- (NADNativeLabel *)prTextLabel
{
    return self.nativeAdPrTextLabel;
}

- (NADNativeLabel *)shortTextLabel
{
    return self.nativeAdShortTextLabel;
}

- (NADNativeLabel *)longTextLabel
{
    return self.nativeAdLongTextLabel;
}

- (NADNativeLabel *)promotionNameLabel
{
    return self.nativeAdPromotionNameLabel;
}

- (NADNativeLabel *)promotionUrlLabel
{
    return self.nativeAdPromotionUrlLabel;
}

- (NADNativeLabel *)actionButtonTextLabel
{
    return self.nativeAdActionButtonTextLabel;
}

- (NADNativeImageView *)adImageView
{
    return self.nativeAdImageView;
}

- (NADNativeImageView *)logoImageView
{
    return self.nativeAdLogoImageView;
}

@end
