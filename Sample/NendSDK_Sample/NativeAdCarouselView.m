//
//  NativeAdCarouselView.m
//  NendSDK_Sample
//
//  Copyright © 2016年 F@N Communications. All rights reserved.
//

#import "NativeAdCarouselView.h"

@interface NativeAdCarouselView ()<NADNativeViewRendering>

@property (nonatomic, weak) IBOutlet NADNativeImageView *nativeAdLogoImageView;
@property (nonatomic, weak) IBOutlet NADNativeLabel *nativeAdPromotionNameLabel;
@property (nonatomic, weak) IBOutlet NADNativeLabel *nativeAdPrTextLabel;
@property (nonatomic, weak) IBOutlet NADNativeLabel *nativeAdLongTextLabel;
@property (nonatomic, weak) IBOutlet NADNativeImageView *nativeAdImageView;
@property (nonatomic, weak) IBOutlet NADNativeLabel *nativeAdShortTextLabel;
@property (nonatomic, weak) IBOutlet NADNativeLabel *nativeAdPromotionUrlLabel;
@property (nonatomic, weak) IBOutlet NADNativeLabel *nativeAdActionButtonTextLabel;

@end

@implementation NativeAdCarouselView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
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
    _nativeAdActionButtonTextLabel.adjustsFontSizeToFitWidth = YES;
    _nativeAdActionButtonTextLabel.minimumScaleFactor = 0.5f;
    _nativeAdActionButtonTextLabel.layer.borderColor = [[UIColor blueColor] CGColor];
    _nativeAdActionButtonTextLabel.layer.borderWidth = 1.f;
    
    self.layer.borderWidth = 0.f;
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
