//
//  NativeAdCarouselView.m
//  NendSDK_Sample
//
//  Copyright © 2016年 F@N Communications. All rights reserved.
//

#import "NativeAdCarouselView.h"

#define cellWidth   [UIScreen mainScreen].bounds.size.width

static const float adPortraitWidth = 320.f; // 立て向き　広告横幅
static const float adPortraitHeight = 325.f; // 立て向き 広告高さ
static const float adLandscapeWidth = 580.f; // 横向き　広告横幅
static const float adLandscapeHeight = 200.f; // 横向き　広告高さ

@interface NativeAdCarouselView ()<NADNativeViewRendering>

@property (nonatomic, weak) IBOutlet NADNativeImageView *nativeAdLogoImageView;
@property (nonatomic, weak) IBOutlet NADNativeLabel *nativeAdPromotionNameLabel;
@property (nonatomic, weak) IBOutlet NADNativeLabel *nativeAdPrTextLabel;
@property (nonatomic, weak) IBOutlet NADNativeLabel *nativeAdLongTextLabel;
@property (nonatomic, weak) IBOutlet NADNativeImageView *nativeAdImageView;
@property (nonatomic, weak) IBOutlet NADNativeLabel *nativeAdShortTextLabel;
@property (nonatomic, weak) IBOutlet NADNativeLabel *nativeAdPromotionUrlLabel;
@property (nonatomic, weak) IBOutlet NADNativeLabel *nativeAdActionButtonTextLabel;

@property (nonatomic) NSNumber *direction;

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

- (void) frameUpdate:direction {
    self.direction = direction;
    [self layoutSubviews];
}

- (void) layoutSubviews {
    [super layoutSubviews];
    
    if ([self.direction intValue] == 1) {
        self.frame = CGRectMake(self.index * adPortraitWidth, 0, adPortraitWidth, adPortraitHeight);
    } else if ([self.direction intValue] == 2) {
        if (cellWidth < adLandscapeWidth) {
            // iphone4の場合、横幅設定
            self.frame = CGRectMake(self.index * (cellWidth - 20.f), 0, (cellWidth - 20.f), adLandscapeHeight);
        } else {
            self.frame = CGRectMake(self.index * adLandscapeWidth, 0, adLandscapeWidth, adLandscapeHeight);
        }
    }
    
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
