//
//  AdIBViewController.m
//  NendSDK_Sample
//
//  Copyright (c) 2015年 F@N Communications. All rights reserved.
//

#import "AdIBViewController.h"

#import "NADView.h"

@interface AdIBViewController () <NADViewDelegate>

@property (nonatomic, weak) IBOutlet NADView *upNadView;      // 標準サイズのバナー
@property (nonatomic, weak) IBOutlet NADView *bottomNadView;  // 広告サイズの自動調整を使用したバナー

@end

@implementation AdIBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }

    // InterfaceBuilderで生成したバナー広告にデリゲートを設定
    self.upNadView.delegate = self;
    self.bottomNadView.delegate = self;
}

// ------------------------------------------------------------------------------------------------
// リフレッシュの中断と再開
// ------------------------------------------------------------------------------------------------

// 画面遷移が発生するような構造で
// 各ViewControllerごとにNADViewインスタンスを生成するような場合には
// 画面の表示状態に応じて pause / resume メッセージを送信し
// 広告のリフレッシュ（定期受信ローテーション）を 一時中断 / 再開 してください
// 無駄なネットワークアクセスや、impressionを抑える事が出来ます。

// この画面が表示される際に広告のリフレッシュを再開します
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 再開
    [self.upNadView resume];
    [self.bottomNadView resume];

    // 注意：他アプリ起動から、自アプリが復帰した際に広告のリフレッシュを再開するには
    // AppDelegate applicationDidEnterBackground などを利用してください
}

// この画面が隠れたら、広告のリフレッシュを中断します
- (void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"ViewController viewWillDisappear");

    // 中断
    [self.upNadView pause];
    [self.bottomNadView pause];

    // 注意：safariなど他アプリが起動し自分自身が背後に回った際に広告のリフレッシュを中止するには
    // AppDelegate applicationDidEnterBackground などを利用してください
}

// ------------------------------------------------------------------------------------------------
// 受信状況の通知
// ------------------------------------------------------------------------------------------------

#pragma mark - NADViewDelegate

// 広告の受信に成功し表示できた場合に１度通知されます。
- (void)nadViewDidFinishLoad:(NADView *)adView
{
    NSLog(@"NADViewDelegate nadViewDidFinishLoad");
}

// 以下は広告受信成功ごとに通知される任意メソッドです。
- (void)nadViewDidReceiveAd:(NADView *)adView
{
    // Success.
    NSLog(@"NADViewDelegate nadViewDidReceiveAd");
}

// 以下は広告受信失敗ごとに通知される任意メソッドです。
- (void)nadViewDidFailToReceiveAd:(NADView *)adView
{
    // Error.
    NSLog(@"NADViewDelegate nadViewDidFailToReceiveAd");

    // エラー発生時の情報をログに出力します
    NSError *nadError = adView.error;
    // エラーコード
    NSLog(@"code = %ld", (long)nadError.code);
    // エラーメッセージ
    NSLog(@"message = %@", nadError.domain);
}

// 以下はバナー広告がクリックされるごとに通知される任意メソッドです。
- (void)nadViewDidClickAd:(NADView *)adView
{
    // Banner clicked.
    NSLog(@"NADViewDelegate nadViewDidClickAd");
}

// ------------------------------------------------------------------------------------------------
// リリース
// ------------------------------------------------------------------------------------------------

#pragma mark - life cycle

- (void)dealloc
{
    // delegateには必ずnilセットして解放する
    self.upNadView.delegate = nil;
    self.bottomNadView.delegate = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
