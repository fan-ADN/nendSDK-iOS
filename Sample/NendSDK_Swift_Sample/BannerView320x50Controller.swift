//
//  BannerViewController.swift
//  NendSwiftSample
//
//  Created by ADN on 2014/09/10.
//  Copyright (c) 2014年 F@N Communications. All rights reserved.
//

import UIKit

class BannerView320x50Controller: UIViewController, NADViewDelegate {

    @IBOutlet weak var bannerViewFromNib: NADView!
    
    private var nadViewManually: NADView!
    
    // ------------------------------------------------------------------------------------------------
    // NADViewを生成、ロード開始
    // ------------------------------------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // InterfaceBuilderで生成したバナー広告にデリゲートを設定
        bannerViewFromNib.delegate = self
        
        
        // コードでバナー広告を生成
//        nadViewManually = NADView()
        // コードでバナー広告を生成(広告サイズの自動調整を行う場合)
        nadViewManually = NADView(isAdjustAdSize: true)
        
        nadViewManually.autoresizingMask = [.FlexibleRightMargin, .FlexibleLeftMargin, .FlexibleTopMargin]
        
        // 広告枠のapikey/spotidを設定(必須)
        nadViewManually.setNendID("a6eca9dd074372c898dd1df549301f277c53f2b9", spotID: "3172")
        
        // nendSDKログ出力の設定(任意)
        nadViewManually.isOutputLog = true
        
        // delegateを受けるオブジェクトを指定(必須)
        nadViewManually.delegate = self
        
        // 読み込み開始(必須)
        nadViewManually.load()
        // 例) 問い合わせエラー時には60分間隔で再問い合わせする
//        nadViewManually.load(["3600":"retry"])
        
    }
    
    // ------------------------------------------------------------------------------------------------
    // リリース
    // ------------------------------------------------------------------------------------------------

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit{
        
        // delegateには必ずnilセットして解放する
        bannerViewFromNib.delegate = nil
        bannerViewFromNib = nil
        
        nadViewManually.delegate = nil
        nadViewManually = nil
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
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // 再開
        bannerViewFromNib.resume()
        nadViewManually.resume()
        
        // 注意：他アプリ起動から、自アプリが復帰した際に広告のリフレッシュを再開するには
        // AppDelegate applicationWillEnterForeground などを利用してください
        
    }
    
    // この画面が隠れたら、広告のリフレッシュを中断します
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 中断
        bannerViewFromNib.pause()
        nadViewManually.pause()
        
        // 注意：safariなど他アプリが起動し自分自身が背後に回った際に広告のリフレッシュを中止するには
        // AppDelegate applicationDidEnterBackground などを利用してください
    }
    
    
    // ------------------------------------------------------------------------------------------------
    // 受信状況の通知
    // ------------------------------------------------------------------------------------------------
    
    // MARK: - NADViewDelegate
    
    // 広告の受信に成功し表示できた場合に１度通知されます。必須メソッドです。
    func nadViewDidFinishLoad(adView: NADView!) {
        if (adView == bannerViewFromNib){
            print("nadViewDidFinishLoad,bannerViewFromNib:\(adView)")
        }else if (adView == nadViewManually){
            print("nadViewDidFinishLoad,nadViewManually:\(adView)")

            // 画面下部に広告を表示させる場合
            nadViewManually.frame = CGRect(x: (self.view.frame.size.width - nadViewManually.frame.size.width)/2, y: self.view.frame.size.height - nadViewManually.frame.size.height, width: nadViewManually.frame.size.width, height: nadViewManually.frame.size.height)

            // 広告のロードが終了してからViewを乗せる場合はnadViewDidFinishLoadを利用します。
            self.view.addSubview(nadViewManually)
        }else{
            
        }
    }
    
    // 以下は広告受信成功ごとに通知される任意メソッドです。
    func nadViewDidReceiveAd(adView: NADView!) {
        if (adView == bannerViewFromNib){
            print("nadViewDidReceiveAd,bannerViewFromNib:\(adView)")
        }else if (adView == nadViewManually){
            print("nadViewDidReceiveAd,nadViewManually:\(adView)")
        }else{
            
        }
    }
    
    // 以下は広告受信失敗ごとに通知される任意メソッドです。
    func nadViewDidFailToReceiveAd(adView: NADView!) {
        
        // エラーごとに処理を分岐する
        let error: NSError = adView.error
        
        switch (error.code){
        case NADViewErrorCode.NADVIEW_AD_SIZE_TOO_LARGE.hashValue:
            // 広告サイズがディスプレイサイズよりも大きい
            break
        case NADViewErrorCode.NADVIEW_INVALID_RESPONSE_TYPE.hashValue:
            // 不明な広告ビュータイプ
            break
        case NADViewErrorCode.NADVIEW_FAILED_AD_REQUEST.hashValue:
            // 広告取得失敗
            break
        case NADViewErrorCode.NADVIEW_FAILED_AD_DOWNLOAD.hashValue:
            // 広告画像の取得失敗
            break
        case NADViewErrorCode.NADVIEW_AD_SIZE_DIFFERENCES.hashValue:
            // リクエストしたサイズと取得したサイズが異なる
            break
        default:
            break
        }
        
        // エラー発生時の情報をログに出力します
        if (adView == bannerViewFromNib){
            print("nadViewDidFailToReceiveAd,bannerViewFromNib,code=\(error.code)")
            print("nadViewDidFailToReceiveAd,bannerViewFromNib,domain=\(error.domain)")
        }else if (adView == nadViewManually){
            print("nadViewDidFailToReceiveAd,nadViewManually,code=\(error.code)")
            print("nadViewDidFailToReceiveAd,nadViewManually,domain=\(error.domain)")
        }else{
            
        }
    }
    
    // 以下はバナー広告がクリックされるごとに通知される任意メソッドです。
    func nadViewDidClickAd(adView: NADView!){
        if (adView == bannerViewFromNib){
            print("nadViewDidClickAd,bannerViewFromNib:\(adView)")
        }else if (adView == nadViewManually){
            print("nadViewDidClickAd,nadViewManually:\(adView)")
        }else{
            
        }
    }


}
