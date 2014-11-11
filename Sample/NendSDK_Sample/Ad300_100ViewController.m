//
//  Ad300_100ViewController.m
//  NendSDK_Sample
//
//  Created by ADN on 2013/07/19.
//  Copyright (c) 2013年 F@N Communications. All rights reserved.
//

#import "Ad300_100ViewController.h"

#define NAD_VIEW_SIZE CGSizeMake(300, 100)

@interface Ad300_100ViewController ()

@end

@implementation Ad300_100ViewController

@synthesize nadView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

// ------------------------------------------------------------------------------------------------
// NADViewを生成、ロード開始
// ------------------------------------------------------------------------------------------------

#pragma mark - 画面読み込み時
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.title = @"300×100";
    
    // Frameを指定してNADViewを生成
    nadView = [[NADView alloc] init];
    [self.nadView setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin];
    
    // nendSDKログ出力の設定(任意)
    [nadView setIsOutputLog:YES];
    
    // 広告枠のapikey/spotidを設定します(必須)
    [nadView setNendID:@"25eb32adddc4f7311c3ec7b28eac3b72bbca5656" spotID:@"70998"];
    
    // delegateを受けるオブジェクトを指定(必須)
    [self.nadView setDelegate:self];
    
    // 背景色を指定(任意)
    [self.nadView setBackgroundColor:[UIColor cyanColor]];
    
    // 読み込み開始(必須)
    [self.nadView load];
    
    // 通知有無にかかわらずViewに乗せる場合
//    [self.view addSubview:self.nadView];
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
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 再開
    [self.nadView resume];
    
    // 注意：他アプリ起動から、自アプリが復帰した際に広告のリフレッシュを再開するには
    // AppDelegate applicationDidEnterBackground などを利用してください
    
    // 広告位置設定例
    // １．画面上部に広告を表示させる場合
    //[self.nadView setFrame:CGRectMake((self.view.frame.size.width - NAD_VIEW_SIZE.width) /2, 0, NAD_VIEW_SIZE.width, NAD_VIEW_SIZE.height)];
    // ２．画面下部に広告を表示させる場合
    [self.nadView setFrame:CGRectMake((self.view.frame.size.width - NAD_VIEW_SIZE.width) /2, self.view.frame.size.height - NAD_VIEW_SIZE.height, NAD_VIEW_SIZE.width, NAD_VIEW_SIZE.height)];
}

// この画面が隠れたら、広告のリフレッシュを中断します
-(void)viewWillDisappear:(BOOL)animated
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
-(void)nadViewDidFinishLoad:(NADView *)adView {
    
    // 広告の受信と表示の成功が通知されてからViewを乗せる場合はnadViewDidFinishLoadを利用します。
    [self.view addSubview:self.nadView];
    
    NSLog(@"NADViewDelegate nadViewDidFinishLoad");
}


// 以下は広告受信成功ごとに通知される任意メソッドです。
-(void)nadViewDidReceiveAd:(NADView *)adView {
    // Success.
    NSLog(@"NADViewDelegate nadViewDidReceiveAd");
}

// 以下は広告受信失敗ごとに通知される任意メソッドです。
-(void)nadViewDidFailToReceiveAd:(NADView *)adView{
    // Error.
    NSLog(@"NADViewDelegate nadViewDidFailToReceiveAd");
    
    // エラー発生時の情報をログに出力します
    NSError* nadError = adView.error;
    // エラーコード
    NSLog(@"code = %ld", (long)nadError.code);
    // エラーメッセージ
    NSLog(@"message = %@", nadError.domain);
}

// 以下はバナー広告がクリックされるごとに通知される任意メソッドです。
-(void)nadViewDidClickAd:(NADView *)adView {
    // Banner clicked.
    NSLog(@"NADViewDelegate nadViewDidClickAd");
}

// ------------------------------------------------------------------------------------------------
// リリース
// ------------------------------------------------------------------------------------------------
#pragma mark - life cycle
-(void)dealloc {
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
