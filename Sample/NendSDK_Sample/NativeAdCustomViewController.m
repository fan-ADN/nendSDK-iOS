//
//  NativeAdCustomViewController.m
//  NendSDK_Sample
//
//  Copyright © 2016年 F@N Communications. All rights reserved.
//

#import "NADNativeClient.h"
#import "NativeAdCustomViewController.h"
#define timerInterval     30.0f

@interface NativeAdCustomViewController () <NADNativeDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *adImage;
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UILabel *shortText;
@property (weak, nonatomic) IBOutlet UILabel *longText;
@property (weak, nonatomic) IBOutlet UILabel *prText;
@property (weak, nonatomic) IBOutlet UILabel *promotionName;
@property (weak, nonatomic) IBOutlet UILabel *promotionUrl;
@property (weak, nonatomic) IBOutlet UILabel *buttonText;
@property (weak, nonatomic) IBOutlet UIView *adView;

- (IBAction)enableAutoReload:(id)sender;
- (IBAction)disableAutoReload:(id)sender;

@property (nonatomic, strong) NADNativeClient *client;

@end

@implementation NativeAdCustomViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [NADNativeLogger setLogLevel:NADNativeLogLevelDebug];
    self.client = [[NADNativeClient alloc] initWithSpotId:@"485504" apiKey:@"30fda4b3386e793a14b27bedb4dcd29f03d638e5"];
    
    __weak typeof(self) weakSelf = self;
    [self.client loadWithCompletionBlock:^(NADNative *ad, NSError *error) {
        if (ad) {
            [weakSelf setUpWithAd:ad];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) setUpWithAd:(NADNative *)ad {
    ad.delegate = self;
    self.shortText.text = ad.shortText;
    self.longText.text = ad.longText;
    self.prText.text = [ad prTextForAdvertisingExplicitly:NADNativeAdvertisingExplicitlyPromotion];
    self.promotionName.text = ad.promotionName;
    self.promotionUrl.text = ad.promotionUrl;
    self.buttonText.text = ad.actionButtonText;
    [ad loadAdImageWithCompletionBlock:^(UIImage *i) {
        self.adImage.image = i;
    }];
    [ad loadLogoImageWithCompletionBlock:^(UIImage *i) {
        self.logoImage.image = i;
    }];
    [ad activateAdView:self.adView withPrLabel:self.prText];
}

- (IBAction)enableAutoReload:(id)sender {
    __weak typeof(self) weakSelf = self;
    [self.client enableAutoReloadWithInterval:timerInterval completionBlock:^(NADNative *ad, NSError *error) {
        if (ad) {
            [weakSelf setUpWithAd:ad];
        }
    }];
}

- (IBAction)disableAutoReload:(id)sender {
    [self.client disableAutoReload];
}

#pragma mark - NADNativeDelegate

- (void)nadNativeDidClickAd:(NADNative *)ad
{
    NSLog(@"nadNativeDidClickAd: %@", ad);
}

@end
