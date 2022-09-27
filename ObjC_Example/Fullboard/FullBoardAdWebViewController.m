//
//  FullBoardAdWebViewController.m
//  ObjC_Example
//
//  Copyright © 2017年 FAN Communications. All rights reserved.
//

#import "FullBoardAdWebViewController.h"
#import <WebKit/WebKit.h>
#import <NendAd/NADFullBoardLoader.h>


@interface FullBoardAdWebViewController () <UIScrollViewDelegate, NADFullBoardDelegate>

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) NADFullBoardLoader *loader;
@property (nonatomic, strong) NADFullBoard *ad;

@end

@implementation FullBoardAdWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:[WKWebViewConfiguration new]];
    self.webView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.webView];
    self.webView.scrollView.delegate = self;
    
    [self.view addConstraints:@[
        [NSLayoutConstraint constraintWithItem:self.webView
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.view
                                     attribute:NSLayoutAttributeTop
                                    multiplier:1
                                      constant:0],
        [NSLayoutConstraint constraintWithItem:self.webView
                                     attribute:NSLayoutAttributeLeading
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.view
                                     attribute:NSLayoutAttributeLeading
                                    multiplier:1
                                      constant:0],
        [NSLayoutConstraint constraintWithItem:self.webView
                                     attribute:NSLayoutAttributeTrailing
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.view
                                     attribute:NSLayoutAttributeTrailing
                                    multiplier:1
                                      constant:0],
        [NSLayoutConstraint constraintWithItem:self.webView
                                     attribute:NSLayoutAttributeBottom
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.view
                                     attribute:NSLayoutAttributeBottom
                                    multiplier:1
                                      constant:0],
    ]];
    
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.nend.net"]]];
    self.loader = [[NADFullBoardLoader alloc] initWithSpotID:485504 apiKey:@"30fda4b3386e793a14b27bedb4dcd29f03d638e5"];
    [self loadAd];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadAd
{
    __weak typeof(self) weakSelf = self;
    [self.loader loadAdWithCompletionHandler:^(NADFullBoard *ad, NADFullBoardLoaderError error) {
        if (weakSelf && ad) {
            ad.delegate = weakSelf;
            weakSelf.ad = ad;
        }
    }];
}

#pragma mark - NADFullBoardDelegate

- (void)NADFullBoardDidDismissAd:(NADFullBoard *)ad
{
    [self loadAd];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y >= scrollView.contentSize.height - scrollView.frame.size.height) {
        if (self.ad) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.ad showFromViewController:self];
            });
        }
    }
}

@end
