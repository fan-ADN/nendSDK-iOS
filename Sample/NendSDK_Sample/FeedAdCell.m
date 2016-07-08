//
//  FeedAdCell.m
//  NendSDK_Sample
//
//  Copyright © 2015年 F@N Communications. All rights reserved.
//

#import "FeedAdCell.h"

@interface FeedAdCell ()

@property (nonatomic, weak) IBOutlet UILabel *nativeAdPrLabel;
@property (nonatomic, weak) IBOutlet UILabel *nativeAdLongTextLabel;
@property (nonatomic, weak) IBOutlet UILabel *nativeAdActionButtonTextLabel;

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

- (UILabel *)prTextLabel
{
    return self.nativeAdPrLabel;
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
