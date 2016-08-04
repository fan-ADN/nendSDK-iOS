//
//  NativeAdCellView.m
//  NendSDK_Sample
//
//  Copyright (c) 2015年 F@N Communications. All rights reserved.
//

#import "NativeAdCellView.h"

@interface NativeAdCellView ()

@property (nonatomic, weak) IBOutlet UILabel *prTextLabel;
@property (nonatomic, weak) IBOutlet UILabel *longTextLabel;
@property (nonatomic, weak) IBOutlet UILabel *actionButtonTextLabel;
@property (nonatomic, weak) IBOutlet UIImageView *adImageView;

@end

@implementation NativeAdCellView

#pragma mark - NADNativeViewRendering.h

- (UILabel *)prTextLabel
{
    return _prTextLabel;
}

- (UILabel *)longTextLabel
{
    return _longTextLabel;
}

- (UILabel *)actionButtonTextLabel
{
    return _actionButtonTextLabel;
}

- (UIImageView *)adImageView
{
    return _adImageView;
}

@end
