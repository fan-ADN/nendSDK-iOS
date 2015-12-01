//
//  NativeAdCollectionView.m
//  NendSDK_Sample
//
//  Copyright (c) 2015年 F@N Communications. All rights reserved.
//

#import "NativeAdCollectionView.h"

@interface NativeAdCollectionView ()

@property (nonatomic, weak) IBOutlet NADNativeLabel *prTextLabel;
@property (nonatomic, weak) IBOutlet NADNativeLabel *shortTextLabel;
@property (nonatomic, weak) IBOutlet NADNativeImageView *adImageView;

@end

@implementation NativeAdCollectionView

#pragma mark - NADNativeViewRendering.h

- (NADNativeLabel *)prTextLabel
{
    return _prTextLabel;
}

- (NADNativeLabel *)shortTextLabel
{
    return _shortTextLabel;
}

- (NADNativeImageView *)adImageView
{
    return _adImageView;
}

@end
