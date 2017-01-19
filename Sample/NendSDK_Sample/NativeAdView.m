//
//  NativeAdView.m
//  NendSDK_Sample
//
//  Copyright (c) 2015年 F@N Communications. All rights reserved.
//

#import "NativeAdView.h"

#import <NendAd/NADNativeViewRendering.h>

@interface NativeAdView () <NADNativeViewRendering>

@property (nonatomic, weak) IBOutlet UILabel *prLabel;
@property (nonatomic, weak) IBOutlet UILabel *shortTextLabel;
@property (nonatomic, weak) IBOutlet UILabel *longTextLabel;
@property (nonatomic, weak) IBOutlet UILabel *promotionNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *promotionUrlLabel;
@property (nonatomic, weak) IBOutlet UILabel *actionButtonTextLabel;
@property (nonatomic, weak) IBOutlet UIImageView *adImageView;
@property (nonatomic, weak) IBOutlet UIImageView *logoImageView;

@end

@implementation NativeAdView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.layer.borderWidth = 1.f;
    
    self.actionButtonTextLabel.layer.borderColor = self.actionButtonTextLabel.textColor.CGColor;
    self.actionButtonTextLabel.layer.borderWidth = 1.f;
    self.actionButtonTextLabel.layer.masksToBounds = YES;
    self.actionButtonTextLabel.layer.cornerRadius = 0.f;
}

#pragma mark - NADNativeViewRendering.h

- (UILabel *)prTextLabel
{
    return _prLabel;
}

- (UILabel *)shortTextLabel
{
    return _shortTextLabel;
}

- (UILabel *)longTextLabel
{
    return _longTextLabel;
}

- (UILabel *)promotionNameLabel
{
    return _promotionNameLabel;
}

- (UILabel *)promotionUrlLabel
{
    return _promotionUrlLabel;
}

- (UILabel *)actionButtonTextLabel
{
    return _actionButtonTextLabel;
}

- (UIImageView *)adImageView
{
    return _adImageView;
}

- (UIImageView *)nadLogoImageView
{
    return _logoImageView;
}

@end
