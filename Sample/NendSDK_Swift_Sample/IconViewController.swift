//
//  IconViewController.swift
//  NendSwiftSample
//
//  Created by ADN on 2014/09/10.
//  Copyright (c) 2014年 F@N Communications. All rights reserved.
//

import UIKit

class IconViewController: UIViewController, NADIconLoaderDelegate {

    @IBOutlet weak var iconArrayViewFromNib: NADIconArrayView!
    
    private var iconLoaderManually: NADIconLoader!
    
    private var iconView: NADIconView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // InterfaceBuilderで生成したアイコン広告にデリゲートを設定
        iconArrayViewFromNib.iconLoader.delegate = self;
        
        // コードで4個のアイコン広告を横に並べて表示する例
        iconLoaderManually = NADIconLoader()

        //アイコン個数を設定
        let iconCount = 4
        
        //画面下部に均等間隔で表示する場合
        for index in 0..<4 {
            //IconViewの生成
            var iconView: NADIconView = NADIconView()
            iconView.autoresizingMask = UIViewAutoresizing.FlexibleRightMargin | UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleTopMargin
            
            //テキスト色の設定(任意)
            iconView.setTextColor(UIColor.whiteColor())
            
            //テキストの表示or非表示(任意)
            iconView.textHidden = true

            //位置の設定
            var pointX: CGFloat = self.view.frame.size.width * CGFloat(index + 1)/CGFloat(iconCount) - (self.view.frame.size.width/CGFloat(iconCount)/2)
            var pointY: CGFloat = CGFloat(self.view.frame.size.height - (75 / 2))
            iconView.center = CGPoint(x:pointX, y:pointY)
            
            //画面上へ追加
            self.view.addSubview(iconView)
            
            //チェック用にタグを設定
            iconView.tag = index+1

            //loaderへ追加
            iconLoaderManually.addIconView(iconView)
        }
        //loaderへの設定
        iconLoaderManually.setNendID("2349edefe7c2742dfb9f434de23bc3c7ca55ad22", spotID: "101281")
        iconLoaderManually.isOutputLog = true
        iconLoaderManually.delegate = self
        
        //load開始
        iconLoaderManually.load()
    }
    
    // ------------------------------------------------------------------------------------------------
    // リリース
    // ------------------------------------------------------------------------------------------------

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit{
        //loaderのdelegateにnilを設定して解放します。
        iconArrayViewFromNib.iconLoader.delegate = nil
        iconLoaderManually.delegate = nil;
        iconLoaderManually = nil;
    }
    
    // ------------------------------------------------------------------------------------------------
    // リフレッシュの中断と再開
    // ------------------------------------------------------------------------------------------------
    
    // 画面遷移が発生するような構造で
    // 各ViewControllerごとにNADIconLoaderインスタンスを生成するような場合には
    // 画面の表示状態に応じて pause / resume メッセージを送信し
    // 広告のリフレッシュ（定期受信ローテーション）を 一時中断 / 再開 してください
    // 無駄なネットワークアクセスや、impressionを抑える事が出来ます。
    
    // この画面が表示される際に広告のリフレッシュを再開します
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // 再開
        iconArrayViewFromNib.iconLoader.resume()
        iconLoaderManually.resume()
        
        // 注意：他アプリ起動から、自アプリが復帰した際に広告のリフレッシュを再開するには
        // AppDelegate applicationDidEnterBackground などを利用してください
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 中断
        iconArrayViewFromNib.iconLoader.pause()
        iconLoaderManually.pause()
        
        // 注意：safariなど他アプリが起動し自分自身が背後に回った際に広告のリフレッシュを中止するには
        // AppDelegate applicationDidEnterBackground などを利用してください
    }
    
    
    // ------------------------------------------------------------------------------------------------
    // 受信状況の通知
    // ------------------------------------------------------------------------------------------------
    
    // MARK: - NADIconLoaderDelegate
    
    // 広告の受信に成功し表示できた場合に１度通知される任意メソッドです。
    func nadIconLoaderDidFinishLoad(iconLoader: NADIconLoader!) {
        if (iconLoader == iconArrayViewFromNib.iconLoader){
            println("nadIconLoaderDidFinishLoad,iconArrayViewFromNib.iconLoader")
        }else if (iconLoader == iconLoaderManually){
            println("nadIconLoaderDidFinishLoad,iconLoaderManually")
        }else{
            
        }
    }
    
    // 以下は広告受信成功ごとに通知される任意メソッドです。
    func nadIconLoaderDidReceiveAd(iconLoader: NADIconLoader!, nadIconView: NADIconView!) {
        if (iconLoader == iconArrayViewFromNib.iconLoader){
            println("nadIconLoaderDidReceiveAd,iconArrayViewFromNib.iconLoader")
        }else if (iconLoader == iconLoaderManually){
            println("nadIconLoaderDidReceiveAd,iconLoaderManually,nadIconView.tag=\(nadIconView.tag)")
        }else{
            
        }
    }
    
    // 以下は広告受信失敗ごとに通知される任意メソッドです。
    func nadIconLoaderDidFailToReceiveAd(iconLoader: NADIconLoader!, nadIconView: NADIconView!) {

        // エラーごとに処理を分岐する
        var error: NSError = iconLoader.error

        switch (error.code){
        case NADViewErrorCode.ADVIEW_AD_SIZE_TOO_LARGE.hashValue:
            // 広告サイズがディスプレイサイズよりも大きい
            break
        case NADViewErrorCode.ADVIEW_INVALID_RESPONSE_TYPE.hashValue:
            // 不明な広告ビュータイプ
            break
        case NADViewErrorCode.ADVIEW_FAILED_AD_REQUEST.hashValue:
            // 広告取得失敗
            break
        case NADViewErrorCode.ADVIEW_FAILED_AD_DOWNLOAD.hashValue:
            // 広告画像の取得失敗
            break
        case NADViewErrorCode.ADVIEW_AD_SIZE_DIFFERENCES.hashValue:
            // リクエストしたサイズと取得したサイズが異なる
            break
        default:
            break
        }

        // エラー発生時の情報をログに出力します
        if (iconLoader == iconArrayViewFromNib.iconLoader){
            println("nadIconLoaderDidFailToReceiveAd,iconArrayViewFromNib.iconLoader,code=\(error.code)")
            println("nadIconLoaderDidFailToReceiveAd,iconArrayViewFromNib.iconLoader,domain=\(error.domain)")
        }else if (iconLoader == iconLoaderManually){
            println("nadIconLoaderDidFailToReceiveAd,iconLoaderManually,code=\(error.code)")
            println("nadIconLoaderDidFailToReceiveAd,iconLoaderManually,domain=\(error.domain)")
        }else{
            
        }
    }
    
    // 以下はアイコン広告がクリックされるごとに通知される任意メソッドです。
    func nadIconLoaderDidClickAd(iconLoader: NADIconLoader!, nadIconView: NADIconView!) {
        if (iconLoader == iconArrayViewFromNib.iconLoader){
            println("nadIconLoaderDidClickAd,iconArrayViewFromNib.iconLoader")
        }else if (iconLoader == iconLoaderManually){
            println("nadIconLoaderDidClickAd,iconLoaderManually,nadIconView.tag=\(nadIconView.tag)")
        }else{
            
        }
    }

}
