//
//  VideoNativeViewController.m
//  NendSDK_Sample
//
//  Copyright © 2018年 F@N Communications. All rights reserved.
//

#import "VideoNativeViewController.h"

@interface VideoNativeViewController () <NADNativeVideoDelegate, NADNativeVideoViewDelegate>

@property (nonatomic) NADNativeVideoLoader *adLoader;

@end

@implementation VideoNativeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.adLoader = [[NADNativeVideoLoader alloc] initWithSpotId:@"input your spot id"
                                                          apiKey:@"input your api key"];
    
    // optional settings
    self.adLoader.userId = @"guestuser";
    NADUserFeature *userFeature = [NADUserFeature new];
    userFeature.gender = NADGenderFemale;
    userFeature.age = 20;
    self.adLoader.userFeature = userFeature;
    [self.adLoader setFillerStaticNativeAdId:@"485500" apiKey:@"10d9088b5bd36cf43b295b0774e5dcf7d20a4071"];
    
    self.videoView.delegate = self;
    self.videoView.rootViewController = self;
    
    // load ads
    UIApplication.sharedApplication.networkActivityIndicatorVisible = YES;
    __weak typeof(self) weakSelf = self;
    [self.adLoader loadAdWithCompletionHandler:^(NADNativeVideo * _Nullable ad, NSError * _Nullable error) {
        UIApplication.sharedApplication.networkActivityIndicatorVisible = NO;
        if (weakSelf) {
            if (ad) {
                if (ad.hasVideo) {
                    ad.delegate = weakSelf;
                    weakSelf.titleLabel.text = [NSString stringWithFormat:@"title:\n%@", ad.title];
                    weakSelf.descriptionLabel.text = [NSString stringWithFormat:@"description:\n%@", ad.explanation];
                    weakSelf.advertiserNameLabel.text = [NSString stringWithFormat:@"advertiserName:\n%@", ad.advertiserName];
                    weakSelf.userRatingLabel.text = [NSString stringWithFormat:@"userRating:\n%f", ad.userRating];
                    weakSelf.userRatingCountLabel.text = [NSString stringWithFormat:@"userRatingCount:\n%ld", (long)ad.userRatingCount];
                    if (ad.logoImage) {
                        weakSelf.logoImageView.image = ad.logoImage;
                    } else {
                        [ad downloadLogoImageWithCompletionHandler:^(UIImage * _Nullable image) {
                            if (weakSelf && image) {
                                weakSelf.logoImageView.image = image;
                            }
                        }];
                    }
                    [weakSelf.callToActionButton setTitle:ad.callToAction forState:UIControlStateNormal];
                    [ad registerInteractionViews:@[weakSelf.callToActionButton]];
                    
                    ad.mutedOnFullScreen = NO;
                    weakSelf.videoView.videoAd = ad;
                } else {
                    NADNative *staticNativeAd = ad.staticNativeAd;
                    NSLog(@"nativeAd: %@", staticNativeAd);
                    // display native ads...
                }
            } else {
                NSLog(@"error: %@", error);
            }
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - NADNativeVideoDelegate

- (void)nadNativeVideoDidImpression:(NADNativeVideo *)ad
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)nadNativeVideoDidClickAd:(NADNativeVideo *)ad
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)nadNativeVideoDidClickInformation:(NADNativeVideo *)ad
{
    NSLog(@"%s", __FUNCTION__);
}

#pragma mark - NADNativeVideoViewDelegate

- (void)nadNativeVideoViewDidStartPlay:(NADNativeVideoView *)videoView
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)nadNativeVideoViewDidStopPlay:(NADNativeVideoView *)videoView
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)nadNativeVideoViewDidFailToPlay:(NADNativeVideoView *)videoView
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)nadNativeVideoViewDidCompletePlay:(NADNativeVideoView *)videoView
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)nadNativeVideoViewDidOpenFullScreen:(NADNativeVideoView *)videoView
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)nadNativeVideoViewDidCloseFullScreen:(NADNativeVideoView *)videoView
{
    NSLog(@"%s", __FUNCTION__);
}

@end
