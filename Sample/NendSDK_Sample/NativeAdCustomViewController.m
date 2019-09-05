//
//  NativeAdCustomViewController.m
//  NendSDK_Sample
//
//  Copyright © 2016年 F@N Communications. All rights reserved.
//

#import <NendAd/NADNativeClient.h>
#import "NativeAdCustomViewController.h"
#define timerInterval     30.0f

@interface NativeAdCustomViewController () <NADNativeDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *adImageView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *shortTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *longTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *prTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *promotionNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *promotionUrlLabel;
@property (weak, nonatomic) IBOutlet UILabel *actionButtonTextLabel;
@property (weak, nonatomic) IBOutlet UIView *adView;

- (IBAction)enableAutoReload:(id)sender;
- (IBAction)disableAutoReload:(id)sender;

@property (nonatomic, strong) NADNativeClient *client;

@end

@implementation NativeAdCustomViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.adView.layer.borderWidth = 1.0;
    self.adView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.actionButtonTextLabel.layer.borderColor = self.actionButtonTextLabel.textColor.CGColor;
    self.actionButtonTextLabel.layer.borderWidth = 1;
    self.actionButtonTextLabel.layer.masksToBounds = YES;
    self.actionButtonTextLabel.layer.cornerRadius = 0;
    self.prTextLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    
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
    self.shortTextLabel.text = ad.shortText;
    self.longTextLabel.text = ad.longText;
    self.prTextLabel.text = [ad prTextForAdvertisingExplicitly:NADNativeAdvertisingExplicitlyPromotion];
    self.promotionNameLabel.text = ad.promotionName;
    self.promotionUrlLabel.text = ad.promotionUrl;
    self.actionButtonTextLabel.text = ad.actionButtonText;
    [ad loadAdImageWithCompletionBlock:^(UIImage *loadAdImage) {
        self.adImageView.image = loadAdImage;
    }];
    [ad loadLogoImageWithCompletionBlock:^(UIImage *loadLogoImage) {
        self.logoImageView.image = loadLogoImage;
    }];
    [ad activateAdView:self.adView withPrLabel:self.prTextLabel];
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
