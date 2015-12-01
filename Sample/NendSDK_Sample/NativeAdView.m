//
//  NativeAdView.m
//  NendSDK_Sample
//
//  Copyright (c) 2015年 F@N Communications. All rights reserved.
//

#import "NativeAdView.h"

#import "NADNativeViewRendering.h"

@interface NativeAdView () <NADNativeViewRendering>

@property (nonatomic, weak) IBOutlet NADNativeLabel *prLabel;
@property (nonatomic, weak) IBOutlet NADNativeLabel *shortTextLabel;
@property (nonatomic, weak) IBOutlet NADNativeLabel *longTextLabel;
@property (nonatomic, weak) IBOutlet NADNativeLabel *promotionNameLabel;
@property (nonatomic, weak) IBOutlet NADNativeLabel *promotionUrlLabel;
@property (nonatomic, weak) IBOutlet NADNativeLabel *actionButtonTextLabel;
@property (nonatomic, weak) IBOutlet NADNativeImageView *adImageView;
@property (nonatomic, weak) IBOutlet NADNativeImageView *logoImageView;

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

- (NADNativeLabel *)prTextLabel
{
    return _prLabel;
}

- (NADNativeLabel *)shortTextLabel
{
    return _shortTextLabel;
}

- (NADNativeLabel *)longTextLabel
{
    return _longTextLabel;
}

- (NADNativeLabel *)promotionNameLabel
{
    return _promotionNameLabel;
}

- (NADNativeLabel *)promotionUrlLabel
{
    return _promotionUrlLabel;
}

- (NADNativeLabel *)actionButtonTextLabel
{
    return _actionButtonTextLabel;
}

- (NADNativeImageView *)adImageView
{
    return _adImageView;
}

- (NADNativeImageView *)logoImageView
{
    return _logoImageView;
}

@end
