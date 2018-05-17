//
//  NativeAdTelopViewController.m
//  NendSDK_Sample
//
//  Copyright © 2016年 F@N Communications. All rights reserved.
//

#import "NativeAdTelopViewController.h"

#import <NendAd/NADNativeClient.h>
#import "NativeAdTelopTextView.h"

@interface NativeAdTelopViewController ()<NADNativeDelegate>

@property (nonatomic) NADNativeClient *client;
@property (nonatomic) IBOutlet NativeAdTelopTextView *adView;

@end

@implementation NativeAdTelopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    _client = [[NADNativeClient alloc] initWithSpotId:@"485500" apiKey:@"10d9088b5bd36cf43b295b0774e5dcf7d20a4071"];
    __weak typeof(self) weakSelf = self;
    [_client loadWithCompletionBlock:^(NADNative *ad, NSError *error) {
        if (ad) {
            ad.delegate = weakSelf;
            // 広告をViewに描画
            [ad intoView:(UIView<NADNativeViewRendering> *)weakSelf.adView advertisingExplicitly:NADNativeAdvertisingExplicitlyAD];
            [weakSelf.adView startTelop];
        } else {
            NSLog(@"load error: %@", error);
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_adView stopTimer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NADNativeDelegate

- (void)nadNativeDidClickAd:(NADNative *)ad
{
    NSLog(@"nadNativeDidClickAd: %@", ad);
}

@end
