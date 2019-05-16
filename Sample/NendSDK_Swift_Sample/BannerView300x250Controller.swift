//
//  BannerView300x250Controller.swift
//  NendSwiftSample
//
//  Copyright (c) 2014年 F@N Communications. All rights reserved.
//

import UIKit
import NendAd

class BannerView300x250Controller: UIViewController, NADViewDelegate {

    @IBOutlet weak var bannerViewFromNib: NADView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "300x250"
        
        // InterfaceBuilderで生成したバナー広告にデリゲートを設定
        bannerViewFromNib.delegate = self
    }

    // ------------------------------------------------------------------------------------------------
    // リリース
    // ------------------------------------------------------------------------------------------------
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        // delegateには必ずnilセットして解放する
        bannerViewFromNib.delegate = nil
        bannerViewFromNib = nil
    }
    
    // ------------------------------------------------------------------------------------------------
    // リフレッシュの中断と再開
    // ------------------------------------------------------------------------------------------------
    
    // この画面が表示される際に広告のリフレッシュを再開します
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 再開
        bannerViewFromNib.resume()
        
        // 注意：他アプリ起動から、自アプリが復帰した際に広告のリフレッシュを再開するには
        // AppDelegate applicationWillEnterForeground などを利用してください
    }
    
    // この画面が隠れたら、広告のリフレッシュを中断します
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 中断
        bannerViewFromNib.pause()
        
        // 注意：safariなど他アプリが起動し自分自身が背後に回った際に広告のリフレッシュを中止するには
        // AppDelegate applicationDidEnterBackground などを利用してください
    }


    // ------------------------------------------------------------------------------------------------
    // 受信状況の通知
    // ------------------------------------------------------------------------------------------------

    // MARK: - NADViewDelegate
    
    // 広告の受信に成功し表示できた場合に１度通知されます。必須メソッドです。
    func nadViewDidFinishLoad(_ adView: NADView!) {
        if (adView == bannerViewFromNib) {
            print("nadViewDidFinishLoad,bannerViewFromNib:\(adView!)")
        } else {
            
        }
    }
    
    // 以下は広告受信成功ごとに通知される任意メソッドです。
    func nadViewDidReceiveAd(_ adView: NADView!) {
        if (adView == bannerViewFromNib) {
            print("nadViewDidReceiveAd,bannerViewFromNib:\(adView!)")
        } else {
            
        }
    }
    
    // 以下は広告受信失敗ごとに通知される任意メソッドです。
    func nadViewDidFail(toReceiveAd adView: NADView!) {
        
        let error: NSError = adView.error as NSError
        
        // エラー発生時の情報をログに出力します
        if (adView == bannerViewFromNib) {
            print("nadViewDidFailToReceiveAd,bannerViewFromNib,code=\(error.code)")
            print("nadViewDidFailToReceiveAd,bannerViewFromNib,domain=\(error.domain)")
        } else {
            
        }
    }
    
    // 以下はバナー広告がクリックされるごとに通知される任意メソッドです。
    func nadViewDidClickAd(_ adView: NADView!) {
        if (adView == bannerViewFromNib) {
            print("nadViewDidClickAd,bannerViewFromNib:\(adView!)")
        } else {
            
        }
    }

    // 以下はインフォメーションボタンがクリックされるごとに通知される任意メソッドです。
    func nadViewDidClickInformation(_ adView: NADView!) {
        if (adView == bannerViewFromNib) {
            print("nadViewDidClickInformation,bannerViewFromNib:\(adView!)")
        } else {
            
        }
    }
}
