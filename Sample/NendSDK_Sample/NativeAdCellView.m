//
//  NativeAdCellView.m
//  NendSDK_Sample
//
//  Copyright (c) 2015年 F@N Communications. All rights reserved.
//

#import "NativeAdCellView.h"

@interface NativeAdCellView ()

@property (nonatomic, weak) IBOutlet NADNativeLabel *prTextLabel;
@property (nonatomic, weak) IBOutlet NADNativeLabel *longTextLabel;
@property (nonatomic, weak) IBOutlet NADNativeLabel *actionButtonTextLabel;
@property (nonatomic, weak) IBOutlet NADNativeImageView *adImageView;

@end

@implementation NativeAdCellView

#pragma mark - NADNativeViewRendering.h

- (NADNativeLabel *)prTextLabel
{
    return _prTextLabel;
}

- (NADNativeLabel *)longTextLabel
{
    return _longTextLabel;
}

- (NADNativeLabel *)actionButtonTextLabel
{
    return _actionButtonTextLabel;
}

- (NADNativeImageView *)adImageView
{
    return _adImageView;
}

@end
