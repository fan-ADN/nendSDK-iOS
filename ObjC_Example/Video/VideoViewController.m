//
//  VideoViewController.m
//  ObjC_Example
//
//  Copyright © 2017年 FAN Communications. All rights reserved.
//

// このサンプルは広告配信に位置情報をオプションで利用しています。
// This sample uses location data as an option for ad supply.

#import "VideoViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <NendAd/NendAd.h>

@interface VideoViewController () <NADInterstitialVideoDelegate, NADRewardedVideoDelegate>

@property (nonatomic) NADRewardedVideo *rewardedVideo;
@property (nonatomic) NADInterstitialVideo *interstitialVideo;
@property (nonatomic) CLLocationManager *locationManager;

@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _locationManager = [[CLLocationManager alloc] init];
    [self.locationManager requestWhenInUseAuthorization];

    self.rewardedVideo = [[NADRewardedVideo alloc] initWithSpotId:@"802555" apiKey:@"ca80ed7018734d16787dbda24c9edd26c84c15b8"];
    self.rewardedVideo.userId = @"user id";
    self.rewardedVideo.delegate = self;
    
    self.interstitialVideo = [[NADInterstitialVideo alloc] initWithSpotId:@"802557" apiKey:@"b6a97b05dd088b67f68fe6f155fb3091f302b48b"];
    self.interstitialVideo.userId = @"user id";
    self.interstitialVideo.isLocationEnabled = NO;
    self.interstitialVideo.delegate = self;
    self.interstitialVideo.isMuteStartPlaying = NO;
    [self.interstitialVideo addFallbackFullboardWithSpotId:@"485504" apiKey:@"30fda4b3386e793a14b27bedb4dcd29f03d638e5"];
}

- (IBAction)loadReward:(id)sender {
    [self.rewardedVideo loadAd];
}

- (IBAction)loadInterstitial:(id)sender {
    [self.interstitialVideo loadAd];
}

- (IBAction)showReward:(id)sender {
    if (self.rewardedVideo.isReady) {
        [self.rewardedVideo showAdFromViewController:self];
    }
}

- (IBAction)showInterstitial:(id)sender {
    if (self.interstitialVideo.isReady) {
        [self.interstitialVideo showAdFromViewController:self];
    }
}

- (IBAction)releaseReward:(id)sender {
    [self.rewardedVideo releaseVideoAd];
}

- (IBAction)releaseInterstitial:(id)sender {
    [self.interstitialVideo releaseVideoAd];
}

#pragma mark - NADRewardVideoDelegate
- (void)nadRewardVideoAd:(NADRewardedVideo *)nadRewardedVideoAd didReward:(NADReward *)reward
{
    NSLog(@"%s %@: %ld", __FUNCTION__, reward.name, (long)reward.amount);
}

- (void)nadRewardVideoAdDidReceiveAd:(NADRewardedVideo *)nadRewardedVideoAd
{
    NSString *adType;
    switch (nadRewardedVideoAd.adType) {
        case NADVideoAdTypeNormal:
            adType = @"normal";
            break;
        case NADVideoAdTypePlayable:
            adType = @"playable";
            break;
        default:
            adType = @"unknown";
            break;
    }
    NSLog(@"%s : Ad Type = %@", __FUNCTION__, adType);
}

- (void)nadRewardVideoAd:(NADRewardedVideo *)nadRewardedVideoAd didFailToLoadWithError:(NSError *)error
{
    NSLog(@"%s error: %@", __FUNCTION__, error);
}

- (void)nadRewardVideoAdDidFailedToPlay:(NADRewardedVideo *)nadRewardedVideoAd
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)nadRewardVideoAdDidOpen:(NADRewardedVideo *)nadRewardedVideoAd
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)nadRewardVideoAdDidClose:(NADRewardedVideo *)nadRewardedVideoAd
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)nadRewardVideoAdDidStartPlaying:(NADRewardedVideo *)nadRewardedVideoAd
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)nadRewardVideoAdDidStopPlaying:(NADRewardedVideo *)nadRewardedVideoAd
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)nadRewardVideoAdDidCompletePlaying:(NADRewardedVideo *)nadRewardedVideoAd
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)nadRewardVideoAdDidClickAd:(NADRewardedVideo *)nadRewardedVideoAd
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)nadRewardVideoAdDidClickInformation:(NADRewardedVideo *)nadRewardedVideoAd
{
    NSLog(@"%s", __FUNCTION__);
}

#pragma mark - NADInterstitialVideoDelegate

- (void)nadInterstitialVideoAdDidReceiveAd:(NADInterstitialVideo *)nadInterstitialVideoAd
{
    NSString *adType;
    switch (nadInterstitialVideoAd.adType) {
        case NADVideoAdTypeNormal:
            adType = @"normal";
            break;
        case NADVideoAdTypePlayable:
            adType = @"playable";
            break;
        default:
            adType = @"unknown";
            break;
    }
    NSLog(@"%s : Ad Type = %@", __FUNCTION__, adType);
}

- (void)nadInterstitialVideoAd:(NADInterstitialVideo *)nadInterstitialVideoAd didFailToLoadWithError:(NSError *)error
{
    NSLog(@"%s error: %@", __FUNCTION__, error);
}

- (void)nadInterstitialVideoAdDidFailedToPlay:(NADInterstitialVideo *)nadInterstitialVideoAd
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)nadInterstitialVideoAdDidOpen:(NADInterstitialVideo *)nadInterstitialVideoAd
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)nadInterstitialVideoAdDidClose:(NADInterstitialVideo *)nadInterstitialVideoAd
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)nadInterstitialVideoAdDidStartPlaying:(NADInterstitialVideo *)nadInterstitialVideoAd
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)nadInterstitialVideoAdDidStopPlaying:(NADInterstitialVideo *)nadInterstitialVideoAd
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)nadInterstitialVideoAdDidCompletePlaying:(NADInterstitialVideo *)nadInterstitialVideoAd
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)nadInterstitialVideoAdDidClickAd:(NADInterstitialVideo *)nadInterstitialVideoAd
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)nadInterstitialVideoAdDidClickInformation:(NADInterstitialVideo *)nadInterstitialVideoAd
{
    NSLog(@"%s", __FUNCTION__);
}

@end
