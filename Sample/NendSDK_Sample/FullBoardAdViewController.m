//
//  FullBoardAdViewController.m
//  NendSDK_Sample
//
//  Created by user on 2017/01/18.
//  Copyright © 2017年 F@N Communications. All rights reserved.
//

#import "FullBoardAdViewController.h"
#import <NendAd/NADFullBoardLoader.h>

@interface FullBoardAdViewController () <NADFullBoardViewDelegate>

@property (nonatomic, strong) NADFullBoardLoader *loader;
@property (nonatomic, strong) NADFullBoard *ad;

@end

@implementation FullBoardAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.loader = [[NADFullBoardLoader alloc] initWithSpotId:@"485504" apiKey:@"30fda4b3386e793a14b27bedb4dcd29f03d638e5"];
    
}

- (IBAction)loadFullBoardAd:(id)sender
{
    __weak typeof(self) weakSelf = self;
    [self.loader loadAdWithCompletionHandler:^(NADFullBoard *ad, NADFullBoardLoaderError error) {
        if (ad) {
            weakSelf.ad = ad;
            weakSelf.ad.delegate = (id)weakSelf;
        } else {
            switch (error) {
                case NADFullBoardLoaderErrorFailedAdRequest:
                    NSLog(@"広告リクエストに失敗しました。");
                    break;
                case NADFullBoardLoaderErrorFailedDownloadImage:
                    NSLog(@"広告画像のダウンロードに失敗しました。");
                    break;
                case NADFullBoardLoaderErrorInvalidAdSpaces:
                    NSLog(@"フルボード広告で利用できない広告枠が指定されました。");
                    break;
                default:
                    break;
            }
        }
    }];
}

- (IBAction)showFullBoardAd:(id)sender
{
    // 第一引数で渡す`UIViewController`は`UIWindow`の階層上に正しく配置されている必要があります
    [self.ad showFromViewController:self];
}

#pragma mark - NADFullBoardDelegate

// 広告表示時に呼び出されます
- (void)NADFullBoardDidShowAd:(NADFullBoard *)ad
{
    NSLog(@"%s", __FUNCTION__);
}

// 広告クリック時に呼び出されます
- (void)NADFullBoardDidClickAd:(NADFullBoard *)ad
{
    NSLog(@"%s", __FUNCTION__);
}

// 広告クローズ時に呼び出されます
- (void)NADFullBoardDidDismissAd:(NADFullBoard *)ad
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
