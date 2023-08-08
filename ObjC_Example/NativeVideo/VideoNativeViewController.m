//
//  VideoNativeViewController.m
//  ObjC_Example
//
//  Copyright © 2018年 FAN Communications. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "NativeVideoAdBaseView.h"
#import "VideoNativeViewController.h"

@import NendAd;

@implementation VideoNativeViewController

NativeVideoAdBaseView *adView;
static NativeVideoAdBaseView *portraitAdView;

+ (NativeVideoAdBaseView *) portraitAdView
{
    @synchronized(self){
        if (!portraitAdView) {
            portraitAdView = [NativeVideoAdBaseView loadPortraitXib];
        }
    }
    return portraitAdView;
}

static NativeVideoAdBaseView *landscapeAdView;

+ (NativeVideoAdBaseView *) landscapeAdView
{
    @synchronized(self){
        if (!landscapeAdView) {
            landscapeAdView = [NativeVideoAdBaseView loadLandscapeXib];
        }
    }
    return landscapeAdView;
}

NADNativeVideoLoader *adLoader;
static NADNativeVideoLoader *portraitLoader;

+ (NADNativeVideoLoader *) portraitLoader
{
    @synchronized(self){
        if (!portraitLoader) {
            portraitLoader = [[NADNativeVideoLoader alloc] initWithSpotID:887595
                                                                   apiKey:@"e7c1e68e7c16e94270bf39719b60534596b1e70d"];
        }
    }
    return portraitLoader;
}

static NADNativeVideoLoader *landscapeLoader;

+ (NADNativeVideoLoader *) landscapeLoader
{
    @synchronized(self){
        if (!landscapeLoader) {
            landscapeLoader =  [[NADNativeVideoLoader alloc] initWithSpotID:887596
                                                                     apiKey:@"8a074ba6a82ca1db39002381239357f9fc68e020"];
        }
    }
    return landscapeLoader;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    BOOL isPortrait = [self checkDeviceOrientation];
    [self setAdLoaderWithOrientation: isPortrait];
    [self setNativeAdWithOrientation: isPortrait];
    [self loadNativeVideoAd];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    BOOL isPortrait = [self checkDeviceOrientation];
    [self setAdLoaderWithOrientation: isPortrait];
    [self setNativeAdWithOrientation: isPortrait];
    [self loadNativeVideoAd];
}

- (BOOL) checkDeviceOrientation
{
    CGRect frame = [[UIScreen mainScreen] bounds];
    
    UIDeviceOrientation orientation = UIDevice.currentDevice.orientation;
    BOOL isPortrait = UIDeviceOrientationIsPortrait(orientation);
    BOOL isLandscape = UIDeviceOrientationIsLandscape(orientation);
    
    if(!isPortrait && !isLandscape) {
        isPortrait = frame.size.width < frame.size.height;
    }
    
    return isPortrait;
}

- (void)setNativeAdWithOrientation:(BOOL)isPortrait
{
    if(adView != nil) {
        [adView removeFromSuperview];
    }
    
    if(isPortrait){
        adView = [VideoNativeViewController portraitAdView];
    } else {
        adView = [VideoNativeViewController landscapeAdView];
    }
    
    adView.frame = self.container.bounds;
    [self.container addSubview: adView];
}

- (void)setAdLoaderWithOrientation:(BOOL)isPortrait
{
    if(adLoader != nil) {
        adLoader = nil;
    }
    if(isPortrait) {
        adLoader = [VideoNativeViewController portraitLoader];
    } else {
        adLoader = [VideoNativeViewController landscapeLoader];
    }
    [adLoader setFillerStaticNativeAdID:485500 apiKey:@"10d9088b5bd36cf43b295b0774e5dcf7d20a4071"];
}

- (void) loadNativeVideoAd {
    
    // Enable this line if your Interface Builder does not configure rootViewController property.
    // adView.videoAdView.rootViewController = self;
    
    // load ads
    __weak typeof(self) weakSelf = self;
    [adLoader loadAdWithCompletionHandler:^(NADNativeVideo * _Nullable ad, NSError * _Nullable error) {
        if (weakSelf) {
            if (ad) {
                if (ad.hasVideo) {
                    ad.delegate = weakSelf;
                    adView.videoAdView.delegate = weakSelf;
                    
                    [adView setTitle: [NSString stringWithFormat:@"title:\n%@", ad.title]];
                    [adView setDescription: [NSString stringWithFormat:@"description:\n%@", ad.explanation]];
                    [adView setAdvertiser: [NSString stringWithFormat:@"advertiserName:\n%@", ad.advertiserName]];
                    [adView setUserRating: [NSString stringWithFormat:@"userRating:\n%f", ad.userRating]];
                    [adView setUserRatingCount: [NSString stringWithFormat:@"userRatingCount:\n%ld", (long)ad.userRatingCount]];
                    if (ad.logoImage) {
                        [adView setLogo: ad.logoImage];
                    } else {
                        [ad downloadLogoImageWithCompletionHandler:^(UIImage * _Nullable image) {
                            if (weakSelf && image) {
                                [adView setLogo: image];
                            }
                        }];
                    }
                    [adView setCtaButtonLabel: ad.callToAction];
                    [ad registerInteractionViews: @[adView.ctaButton]];
                    ad.mutedOnFullScreen = NO;
                    
                    [adView setVideoAd: ad];
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

//- (UIInterfaceOrientationMask)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskPortrait;
//}

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

- (void)nadNativeVideoViewDidStartFullScreenPlaying:(NADNativeVideoView *)videoView
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)nadNativeVideoViewDidStopFullScreenPlaying:(NADNativeVideoView *)videoView
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)terminate
{
    portraitAdView = nil;
    landscapeAdView = nil;
    portraitLoader = nil;
    landscapeLoader = nil;
}

@end
