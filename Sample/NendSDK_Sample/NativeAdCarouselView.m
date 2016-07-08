//
//  NativeAdCarouselView.m
//  NendSDK_Sample
//
//  Copyright © 2016年 F@N Communications. All rights reserved.
//

#import "NativeAdCarouselView.h"

#define cellWidth   [UIScreen mainScreen].bounds.size.width

static const float adPortraitWidth = 320.f; // 縦向き　広告横幅
static const float adPortraitHeight = 325.f; // 縦向き 広告高さ
static const float adLandscapeWidth = 580.f; // 横向き　広告横幅
static const float adLandscapeHeight = 200.f; // 横向き　広告高さ

@interface NativeAdCarouselView ()<NADNativeViewRendering>

@property (nonatomic, weak) IBOutlet UIImageView *nativeAdLogoImageView;
@property (nonatomic, weak) IBOutlet UILabel *nativeAdPromotionNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *nativeAdPrTextLabel;
@property (nonatomic, weak) IBOutlet UILabel *nativeAdLongTextLabel;
@property (nonatomic, weak) IBOutlet UIImageView *nativeAdImageView;
@property (nonatomic, weak) IBOutlet UILabel *nativeAdShortTextLabel;
@property (nonatomic, weak) IBOutlet UILabel *nativeAdPromotionUrlLabel;
@property (nonatomic, weak) IBOutlet UILabel *nativeAdActionButtonTextLabel;

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
    _nativeAdActionButtonTextLabel.layer.borderColor = [UIColor blueColor].CGColor;
    _nativeAdActionButtonTextLabel.layer.borderWidth = 1.f;
    
    self.layer.borderWidth = 0.f;
}

- (void) frameUpdate:direction {
    self.direction = direction;
    [self layoutSubviews];
}

- (void) layoutSubviews {
    [super layoutSubviews];
    
    if ((self.direction).intValue == 1) {
        self.frame = CGRectMake(self.index * adPortraitWidth, 0, adPortraitWidth, adPortraitHeight);
    } else if ((self.direction).intValue == 2) {
        if (cellWidth < adLandscapeWidth) {
            // iphone4の場合、横幅設定
            self.frame = CGRectMake(self.index * (cellWidth - 20.f), 0, (cellWidth - 20.f), adLandscapeHeight);
        } else {
            self.frame = CGRectMake(self.index * adLandscapeWidth, 0, adLandscapeWidth, adLandscapeHeight);
        }
    }
    
}

#pragma mark - NADNativeViewRendering

- (UILabel *)prTextLabel
{
    return self.nativeAdPrTextLabel;
}

- (UILabel *)shortTextLabel
{
    return self.nativeAdShortTextLabel;
}

- (UILabel *)longTextLabel
{
    return self.nativeAdLongTextLabel;
}

- (UILabel *)promotionNameLabel
{
    return self.nativeAdPromotionNameLabel;
}

- (UILabel *)promotionUrlLabel
{
    return self.nativeAdPromotionUrlLabel;
}

- (UILabel *)actionButtonTextLabel
{
    return self.nativeAdActionButtonTextLabel;
}

- (UIImageView *)adImageView
{
    return self.nativeAdImageView;
}

- (UIImageView *)logoImageView
{
    return self.nativeAdLogoImageView;
}

@end
