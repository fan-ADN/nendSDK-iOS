//
//  FeedAdView.m
//  ObjC_Example
//
//  Copyright © 2015年 FAN Communications. All rights reserved.
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
    
    if (@available(iOS 13.0, *)) {
        self.backgroundColor = [UIColor colorNamed:@"NativeAdBackgroundColor"];
        self.nativeAdPrTextLabel.textColor = [UIColor colorNamed:@"TextColor"];
        self.nativeAdLongTextLabel.textColor = [UIColor colorNamed:@"TextColor"];
    }
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
