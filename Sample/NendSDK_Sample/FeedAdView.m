//
//  FeedAdView.m
//  NendSDK_Sample
//
//  Copyright © 2015年 F@N Communications. All rights reserved.
//

#import "FeedAdView.h"

@interface FeedAdView ()

@property (nonatomic, weak) IBOutlet UILabel *nativeAdPrTextLabel;
@property (nonatomic, weak) IBOutlet UILabel *nativeAdLongTextLabel;
@property (nonatomic, weak) IBOutlet UILabel *nativeAdActionButtonTextLabel;

@end

@implementation FeedAdView

#pragma mark - NADNativeViewRendering

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.nativeAdActionButtonTextLabel.layer.borderColor = self.nativeAdActionButtonTextLabel.textColor.CGColor;
    self.nativeAdActionButtonTextLabel.layer.borderWidth = 1.f;
    self.nativeAdActionButtonTextLabel.layer.masksToBounds = YES;
    self.nativeAdActionButtonTextLabel.layer.cornerRadius = 0.f;
}

- (UILabel *)prTextLabel
{
    return self.nativeAdPrTextLabel;
}

- (UILabel *)longTextLabel
{
    return self.nativeAdLongTextLabel;
}

- (UILabel *)actionButtonTextLabel
{
    return self.nativeAdActionButtonTextLabel;
}

@end
