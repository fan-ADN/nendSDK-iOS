//
//  NativeAdViewController.m
//  NendSDK_Sample
//
//  Copyright (c) 2015年 F@N Communications. All rights reserved.
//

#import "NativeAdViewController.h"

#import <NendAd/NADNativeClient.h>

@interface NativeAdViewController () <NADNativeDelegate>

@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *indicator;
@property (nonatomic) NADNativeClient *client;

@end

@implementation NativeAdViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

     // Xibから広告Viewを生成
    UINib *nib = [UINib nibWithNibName:self.nib bundle:nil];
    UIView<NADNativeViewRendering> *adView = [nib instantiateWithOwner:nil options:nil][0];
    adView.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
    adView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:adView];
    [self.view addConstraints:@[
        [NSLayoutConstraint constraintWithItem:adView
                                     attribute:NSLayoutAttributeCenterX
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.view
                                     attribute:NSLayoutAttributeCenterX
                                    multiplier:1.f
                                      constant:0.f],
        [NSLayoutConstraint constraintWithItem:adView
                                     attribute:NSLayoutAttributeCenterY
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.view
                                     attribute:NSLayoutAttributeCenterY
                                    multiplier:1.f
                                      constant:0.f],
        [NSLayoutConstraint constraintWithItem:adView
                                     attribute:NSLayoutAttributeWidth
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:nil
                                     attribute:NSLayoutAttributeWidth
                                    multiplier:1.f
                                      constant:CGRectGetWidth(adView.bounds)],
        [NSLayoutConstraint constraintWithItem:adView
                                     attribute:NSLayoutAttributeHeight
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:nil
                                     attribute:NSLayoutAttributeHeight
                                    multiplier:1.f
                                      constant:CGRectGetHeight(adView.bounds)],
    ]];

    [self.view bringSubviewToFront:self.indicator];

    [NADNativeLogger setLogLevel:NADNativeLogLevelWarn];
    
    self.client = [[NADNativeClient alloc] initWithSpotId:self.spotId apiKey:self.apiKey];
    
    __weak typeof(self) weakSelf = self;
    [self.client loadWithCompletionBlock:^(NADNative *ad, NSError *error) {
        if (ad) {
            ad.delegate = weakSelf;
            // 広告をViewに描画
            [ad intoView:adView advertisingExplicitly:NADNativeAdvertisingExplicitlyPR];
        } else {
            NSLog(@"load error: %@", error);
        }
        weakSelf.indicator.hidden = YES;
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NADNativeDelegate

- (void)nadNativeDidClickAd:(NADNative *)ad
{
    NSLog(@"nadNativeDidClickAd");
}

@end
