//
//  AdInterstitialViewController.m
//  NendSDK_Sample
//
//  Created by ADN on 2014/07/11.
//  Copyright (c) 2014年 F@N Communications. All rights reserved.
//

#import "AdInterstitialViewController.h"

#import "NADInterstitial.h"

//#define ONLY_PORTRAIT   1
//#define ONLY_LANDSCAPE  1

@interface AdInterstitialViewController () <NADInterstitialDelegate>

- (IBAction) show:(id)sender;

@end

@implementation AdInterstitialViewController

- (void) dealloc
{
    // 解放時、デリゲートにnilを設定します
    [NADInterstitial sharedInstance].delegate = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"Interstitial";
    
    // エラーログの出力をONにします
    [NADInterstitial sharedInstance].isOutputLog = YES;
    
    // デリゲートを設定します
    [NADInterstitial sharedInstance].delegate = self;

#ifdef ONLY_PORTRAIT
    // iOS5用に広告の向きを縦向きのみに限定します
    NSArray* array = @[[NSNumber numberWithInteger:UIInterfaceOrientationPortrait], [NSNumber numberWithInteger:UIInterfaceOrientationPortraitUpsideDown]];
    [NADInterstitial sharedInstance].supportedOrientations = array;
#elif ONLY_LANDSCAPE
    // iOS5用に広告の向きを横向きのみに限定します
    NSArray* array = @[[NSNumber numberWithInteger:UIInterfaceOrientationLandscapeLeft], [NSNumber numberWithInteger:UIInterfaceOrientationLandscapeRight]];
    [NADInterstitial sharedInstance].supportedOrientations = array;
#endif

    // 広告の読み込みを行います
    [[NADInterstitial sharedInstance] loadAdWithApiKey:@"308c2499c75c4a192f03c02b2fcebd16dcb45cc9" spotId:@"213208"];
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
#ifdef ONLY_PORTRAIT
    // iOS5用に端末回転を縦向きのみに限定します
    return UIInterfaceOrientationIsPortrait(toInterfaceOrientation);
#elif ONLY_LANDSCAPE
    // iOS5用に端末回転を横向きのみに限定します
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
#else
    return YES;
#endif
}

- (IBAction) show:(id)sender
{
    // 広告を表示します
    NSLog(@"+++++ %@ +++++", [self stringForShowResult:[[NADInterstitial sharedInstance] showAd]]);
}

- (NSString *)stringForStatusCode:(NADInterstitialStatusCode)code
{
    switch ( code )
    {
        case SUCCESS:
            return @"SUCCESS";
        case FAILED_AD_DOWNLOAD:
            return @"FAILED_AD_DOWNLOAD";
        case FAILED_AD_REQUEST:
            return @"FAILED_AD_REQUEST";
        case INVALID_RESPONSE_TYPE:
            return @"INVALID_RESPONSE_TYPE";
        default:
            return @"UNKNOWN";
    }
}

- (NSString *) stringForClickType:(NADInterstitialClickType)type
{
    switch ( type )
    {
        case DOWNLOAD:
            return @"DOWNLOAD";
        case CLOSE:
            return @"CLOSE";
        default:
            return @"UNKNOWN";
    }
}

- (NSString *) stringForShowResult:(NADInterstitialShowResult)result
{
    switch ( result )
    {
        case AD_SHOW_SUCCESS:
            return @"AD_SHOW_SUCCESS";
        case AD_DOWNLOAD_INCOMPLETE:
            return @"AD_DOWNLOAD_INCOMPLETE";
        case AD_FREQUENCY_NOT_REACHABLE:
            return @"AD_FREQUENCY_NOT_REACHABLE";
        case AD_LOAD_INCOMPLETE:
            return @"AD_LOAD_INCOMPLETE";
        case AD_REQUEST_INCOMPLETE:
            return @"AD_REQUEST_INCOMPLETE";
        case AD_SHOW_ALREADY:
            return @"AD_SHOW_ALREADY";
        default:
            return @"UNKNOWN";
    }
}

- (void) didFinishLoadInterstitialAdWithStatus:(NADInterstitialStatusCode)status
{
    // 広告のロード結果を受け取ります
    NSLog(@"+++++ %@ +++++", [self stringForStatusCode:status]);
}

- (void) didClickWithType:(NADInterstitialClickType)type
{
    // 広告上のクリックイベントを受け取ります
    NSLog(@"+++++ %@ +++++", [self stringForClickType:type]);
}

@end