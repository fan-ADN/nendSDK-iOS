//
//  BannerView320x100Controller.swift
//  NendSwiftSample
//
//  Created by ADN on 2014/09/10.
//  Copyright (c) 2014年 F@N Communications. All rights reserved.
//

import UIKit

class BannerView320x100Controller: UIViewController, NADViewDelegate {

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
        nadViewManually = NADView()
        nadViewManually.autoresizingMask = UIViewAutoresizing.FlexibleRightMargin | UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleTopMargin
        
        // 広告枠のapikey/spotidを設定(必須)
        nadViewManually.setNendID("eb5ca11fa8e46315c2df1b8e283149049e8d235e", spotID: "70996")
        
        // nendSDKログ出力の設定(任意)
        nadViewManually.isOutputLog = true
        
        // delegateを受けるオブジェクトを指定(必須)
        nadViewManually.delegate = self
        
        // 読み込み開始(必須)
        nadViewManually.load()
        
        // 通知有無にかかわらずViewに乗せる場合
//        self.view.addSubview(nadViewManually)
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
        
        // 画面下部に広告を表示させる場合
        nadViewManually.frame = CGRect(x: (self.view.frame.size.width - 320)/2, y: self.view.frame.size.height - 100, width: 320, height: 100)
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
            println("nadViewDidFinishLoad,bannerViewFromNib:\(adView)")
        }else if (adView == nadViewManually){
            println("nadViewDidFinishLoad,nadViewManually:\(adView)")
            
            // 広告の受信と表示の成功が通知されてからViewを乗せる場合はnadViewDidFinishLoadを利用します。
            self.view.addSubview(nadViewManually)
        }else{
            
        }
    }
    
    // 以下は広告受信成功ごとに通知される任意メソッドです。
    func nadViewDidReceiveAd(adView: NADView!) {
        if (adView == bannerViewFromNib){
            println("nadViewDidReceiveAd,bannerViewFromNib:\(adView)")
        }else if (adView == nadViewManually){
            println("nadIconLoaderDidFinishLoad,nadViewManually:\(adView)")
        }else{
            
        }
    }
    
    // 以下は広告受信失敗ごとに通知される任意メソッドです。
    func nadViewDidFailToReceiveAd(adView: NADView!) {
        
        var error: NSError = adView.error
        
        // エラー発生時の情報をログに出力します
        if (adView == bannerViewFromNib){
            println("nadViewDidFailToReceiveAd,bannerViewFromNib,code=\(error.code)")
            println("nadViewDidFailToReceiveAd,bannerViewFromNib,domain=\(error.domain)")
        }else if (adView == nadViewManually){
            println("nadViewDidFailToReceiveAd,nadViewManually,code=\(error.code)")
            println("nadViewDidFailToReceiveAd,nadViewManually,domain=\(error.domain)")
        }else{
            
        }
    }
    
    // 以下はバナー広告がクリックされるごとに通知される任意メソッドです。
    func nadViewDidClickAd(adView: NADView!){
        if (adView == bannerViewFromNib){
            println("nadViewDidClickAd,bannerViewFromNib:\(adView)")
        }else if (adView == nadViewManually){
            println("nadViewDidClickAd,nadViewManually:\(adView)")
        }else{
            
        }
    }

}
