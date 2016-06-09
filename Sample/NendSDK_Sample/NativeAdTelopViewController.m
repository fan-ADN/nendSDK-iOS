//
//  NativeAdTelopViewController.m
//  NendSDK_Sample
//
//  Copyright © 2016年 F@N Communications. All rights reserved.
//

#import "NativeAdTelopViewController.h"
#import "NADNativeClient.h"
#import "NativeAdTelopTextView.h"

@interface NativeAdTelopViewController ()<NADNativeDelegate>

@property (nonatomic) NADNativeClient *client;
@property (nonatomic) IBOutlet NativeAdTelopTextView *adView;

@end

@implementation NativeAdTelopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [NADNativeLogger setLogLevel:NADNativeLogLevelDebug];
    
    _client = [[NADNativeClient alloc] initWithSpotId:@"485500" apiKey:@"10d9088b5bd36cf43b295b0774e5dcf7d20a4071" advertisingExplicitly:NADNativeAdvertisingExplicitlyAD];
    _client.delegate = self;
    [_client loadWithCompletionBlock:^(NADNative *ad, NSError *error) {
        if (ad) {
            // 広告をViewに描画
            [ad intoView:(UIView<NADNativeViewRendering> *)_adView];
            [_adView startTelop];
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

- (void)nadNativeDidDisplayAd:(NADNative *)ad success:(BOOL)success
{
    NSLog(@"nadNativeDidDisplayAd: %@", ad);
}

@end
