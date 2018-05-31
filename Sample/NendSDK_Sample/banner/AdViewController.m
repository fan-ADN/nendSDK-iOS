//
//  AdViewController.m
//  NendSDK_Sample
//
//  Copyright (c) 2015年 F@N Communications. All rights reserved.
//

#import "AdViewController.h"

#import <NendAd/NADView.h>

@interface AdViewController () <NADViewDelegate>

@property (nonatomic) NADView *nadView;

@end

@implementation AdViewController

// ------------------------------------------------------------------------------------------------
// NADViewを生成、ロード開始
// ------------------------------------------------------------------------------------------------

#pragma mark - 画面読み込み時

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    // NADViewを生成
    self.nadView = [[NADView alloc] init];
    (self.nadView).autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;

    // 広告枠のapikey/spotidを設定します(必須)
    [self.nadView setNendID:self.apiKey spotID:self.spotId];

    // delegateを受けるオブジェクトを指定(任意)
    (self.nadView).delegate = self;

    // 背景色を指定(任意)
    (self.nadView).backgroundColor = [UIColor cyanColor];

    // 読み込み開始(必須)
    [self.nadView load];
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
    [self.nadView resume];

    // 注意：他アプリ起動から、自アプリが復帰した際に広告のリフレッシュを再開するには
    // AppDelegate applicationDidEnterBackground などを利用してください
}

// この画面が隠れたら、広告のリフレッシュを中断します
- (void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"ViewController viewWillDisappear");

    // 中断
    [self.nadView pause];

    // 注意：safariなど他アプリが起動し自分自身が背後に回った際に広告のリフレッシュを中止するには
    // AppDelegate applicationDidEnterBackground などを利用してください
}

// ------------------------------------------------------------------------------------------------
// 受信状況の通知
// ------------------------------------------------------------------------------------------------

#pragma mark - NADViewDelegate

// 広告の受信に成功し表示できた場合に１度通知されます。必須メソッドです。
- (void)nadViewDidFinishLoad:(NADView *)adView
{
    // 広告のロードが終了してからViewを乗せる場合はnadViewDidFinishLoadを利用します。

    // 広告位置設定例
    // １．画面上部に広告を表示させる場合
    // [self.nadView setFrame:CGRectMake((self.view.frame.size.width - self.nadView.frame.size) /2, 0, self.nadView.frame.size, self.nadView.frame.size)];
    // ２．画面下部に広告を表示させる場合
    (self.nadView).frame = CGRectMake((self.view.frame.size.width - self.nadView.frame.size.width) / 2, self.view.frame.size.height - self.nadView.frame.size.height, self.nadView.frame.size.width,
                                      self.nadView.frame.size.height);

    [self.view addSubview:self.nadView];

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

// 以下はインフォメーションボタンがクリックされるごとに通知される任意メソッドです。
- (void)nadViewDidClickInformation:(NADView *)adView
{
    // Information clicked.
    NSLog(@"NADViewDelegate nadViewDidClickInformation");
}

// ------------------------------------------------------------------------------------------------
// リリース
// ------------------------------------------------------------------------------------------------

#pragma mark - life cycle

- (void)dealloc
{
    // delegateには必ずnilセットして解放する
    [self.nadView setDelegate:nil];
    self.nadView = nil;
}

- (void)didReceiveMemoryWarning
{
    NSLog(@"ViewController didReceiveMemoryWarning");

    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
