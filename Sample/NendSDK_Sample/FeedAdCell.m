//
//  FeedAdCell.m
//  NendSDK_Sample
//
//  Copyright © 2015年 F@N Communications. All rights reserved.
//

#import "FeedAdCell.h"

@interface FeedAdCell ()

@property (nonatomic, weak) IBOutlet NADNativeLabel *nativeAdPrLabel;
@property (nonatomic, weak) IBOutlet NADNativeLabel *nativeAdLongTextLabel;
@property (nonatomic, weak) IBOutlet NADNativeLabel *nativeAdActionButtonTextLabel;

@end

@implementation FeedAdCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.nativeAdActionButtonTextLabel.layer.borderColor = self.nativeAdActionButtonTextLabel.textColor.CGColor;
    self.nativeAdActionButtonTextLabel.layer.borderWidth = 1.f;
    self.nativeAdActionButtonTextLabel.layer.masksToBounds = YES;
    self.nativeAdActionButtonTextLabel.layer.cornerRadius = 0.f;
}

#pragma mark - NADNativeViewRendering

- (NADNativeLabel *)prTextLabel
{
    return self.nativeAdPrLabel;
}

- (NADNativeLabel *)longTextLabel
{
    return self.nativeAdLongTextLabel;
}

- (NADNativeLabel *)actionButtonTextLabel
{
    return self.nativeAdActionButtonTextLabel;
}

@end
