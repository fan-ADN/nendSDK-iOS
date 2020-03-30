//
//  NativeAdPageContentViewController.m
//  ObjC_Example
//
//  Copyright (c) 2015年 FAN Communications. All rights reserved.
//

#import "NativeAdPageContentViewController.h"

@interface NativeAdPageContentViewController ()

@property (nonatomic, weak) IBOutlet UIView<NADNativeViewRendering> *adView;
@property (nonatomic, weak) IBOutlet UILabel *label;

@end

@implementation NativeAdPageContentViewController

- (void)setAd:(NADNative *)ad
{
    [ad intoView:self.adView advertisingExplicitly:NADNativeAdvertisingExplicitlyPromotion];
}

- (void)setPosition:(NSUInteger)position
{
    self.label.text = [NSString stringWithFormat:@"Page%lu", (unsigned long)position];
}

@end
