//
//  NativeAdNoNibViewController.m
//  ObjC_Example
//
//  Copyright © 2015年 FAN Communications. All rights reserved.
//

#import "NativeAdNoNibViewController.h"

#import <NendAd/NADNativeClient.h>

@interface NativeAdViewInternal : UIView <NADNativeViewRendering>

@property (nonatomic, strong) UIImageView *nativeAdImageView;
@property (nonatomic, strong) UILabel *nativeAdPrTextLabel;
@property (nonatomic, strong) UILabel *nativeAdShortTextLabel;

@end

@interface NativeAdNoNibViewController ()

@property (nonatomic, strong) NADNativeClient *client;

@end

@implementation NativeAdNoNibViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.client = [[NADNativeClient alloc] initWithSpotId:@"485500"
                                                   apiKey:@"10d9088b5bd36cf43b295b0774e5dcf7d20a4071"];
    
    UIView<NADNativeViewRendering> *adView = [[NativeAdViewInternal alloc] initWithFrame:CGRectMake(0.f, 0.f, 320.f, 96.f)];
    adView.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame));
    [self.view addSubview:adView];
    [self.client loadWithCompletionBlock:^(NADNative *ad, NSError *error) {
        if (ad) {
            [ad intoView:adView advertisingExplicitly:NADNativeAdvertisingExplicitlyPR];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation NativeAdViewInternal

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _nativeAdImageView = [[UIImageView alloc] initWithFrame:CGRectMake(8.f, 8.f, 80.f, 80.f)];
        _nativeAdShortTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(96.f, 8.f, 218.f, 40.f)];
        _nativeAdShortTextLabel.adjustsFontSizeToFitWidth = YES;
        _nativeAdShortTextLabel.minimumScaleFactor = 0.5f;
        _nativeAdPrTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(96.f, 48.f, 218.f, 40.f)];
        [self addSubview:_nativeAdImageView];
        [self addSubview:_nativeAdShortTextLabel];
        [self addSubview:_nativeAdPrTextLabel];
        
        self.layer.borderColor = [UIColor darkGrayColor].CGColor;
        self.layer.borderWidth = 1.f;
    }
    return self;
}

#pragma mark - NADNativeViewRendering

- (UILabel *)prTextLabel
{
    return self.nativeAdPrTextLabel;
}

- (UILabel *)shortTextLabel
{
    return self.nativeAdShortTextLabel;
}

- (UIImageView *)adImageView
{
    return self.nativeAdImageView;
}


@end
