//
//  NativeAdCollectionView.m
//  NendSDK_Sample
//
//  Copyright (c) 2015年 F@N Communications. All rights reserved.
//

#import "NativeAdCollectionView.h"

@interface NativeAdCollectionView ()

@property (nonatomic, weak) IBOutlet UILabel *prTextLabel;
@property (nonatomic, weak) IBOutlet UILabel *shortTextLabel;
@property (nonatomic, weak) IBOutlet UIImageView *adImageView;

@end

@implementation NativeAdCollectionView

#pragma mark - NADNativeViewRendering.h

- (UILabel *)prTextLabel
{
    return _prTextLabel;
}

- (UILabel *)shortTextLabel
{
    return _shortTextLabel;
}

- (UIImageView *)adImageView
{
    return _adImageView;
}

@end
