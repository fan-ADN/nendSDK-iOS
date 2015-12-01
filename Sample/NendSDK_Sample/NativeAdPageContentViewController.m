//
//  NativeAdPageContentViewController.m
//  NendSDK_Sample
//
//  Copyright (c) 2015年 F@N Communications. All rights reserved.
//

#import "NativeAdPageContentViewController.h"

@interface NativeAdPageContentViewController ()

@property (nonatomic, weak) IBOutlet UIView<NADNativeViewRendering> *adView;
@property (nonatomic, weak) IBOutlet UILabel *label;

@end

@implementation NativeAdPageContentViewController

- (void)setAd:(NADNative *)ad
{
    [ad intoView:self.adView];
}

- (void)setPosition:(NSUInteger)position
{
    self.label.text = [NSString stringWithFormat:@"Page%lu", (unsigned long)position];
}

@end
