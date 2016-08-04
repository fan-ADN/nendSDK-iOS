//
//  NativeAdNoNibTelopViewController.m
//  NendSDK_Sample
//
//  Copyright © 2016年 F@N Communications. All rights reserved.
//

#import "NADNativeClient.h"
#import "NativeAdNoNibTelopTextView.h"
#import "NativeAdNoNibTelopViewController.h"

static float NATIVE_TELOP_VIEW_WIDTH = 150;
static float NATIVE_TELOP_VIEW_HEIGHT = 30;

@interface NativeAdNoNibTelopViewController () <NADNativeDelegate>

@property (nonatomic) NADNativeClient *client;
@property (nonatomic) NativeAdNoNibTelopTextView *adView;

@end

@implementation NativeAdNoNibTelopViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    _adView = [[NativeAdNoNibTelopTextView alloc] initWithFrame:CGRectMake(0, 0, NATIVE_TELOP_VIEW_WIDTH, NATIVE_TELOP_VIEW_HEIGHT)];
    _adView.center = self.view.center;
    _adView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [self.view addSubview:_adView];

    [NADNativeLogger setLogLevel:NADNativeLogLevelDebug];

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

@end
