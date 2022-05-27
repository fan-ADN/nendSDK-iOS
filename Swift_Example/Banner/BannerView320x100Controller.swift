//
//  BannerView320x100Controller.swift
//  NendSwiftSample
//
//  Copyright (c) 2014年 FAN Communications. All rights reserved.
//

import UIKit
import NendAd

class BannerView320x100Controller: UIViewController, NADViewDelegate {

    @IBOutlet weak var bannerViewFromNib: NADView!
    
    fileprivate var nadViewManually: NADView!
    
    
    // ------------------------------------------------------------------------------------------------
    // NADViewを生成、ロード開始
    // ------------------------------------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "320x100"

        // InterfaceBuilderで生成したバナー広告にデリゲートを設定
        bannerViewFromNib.delegate = self
        
        // コードでバナー広告を生成
//        nadViewManually = NADView()
        // コードでバナー広告を生成(広告サイズの自動調整を行う場合)
        nadViewManually = NADView(isAdjustAdSize: true)

        // 広告枠のspotid/apikeyを設定(必須)
        nadViewManually.setNendID(70996, apiKey: "eb5ca11fa8e46315c2df1b8e283149049e8d235e")
        
        // delegateを受けるオブジェクトを指定(必須)
        nadViewManually.delegate = self
        
        // 読み込み開始(必須)
        nadViewManually.load()
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 再開
        bannerViewFromNib.resume()
        nadViewManually.resume()
        
        // 注意：他アプリ起動から、自アプリが復帰した際に広告のリフレッシュを再開するには
        // AppDelegate applicationWillEnterForeground などを利用してください
        
    }
    
    // この画面が隠れたら、広告のリフレッシュを中断します
    override func viewWillDisappear(_ animated: Bool) {
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
    func nadViewDidFinishLoad(_ adView: NADView!) {
        if (adView == bannerViewFromNib) {
            print("nadViewDidFinishLoad,bannerViewFromNib:\(adView!)")
        } else if (adView == nadViewManually) {
            print("nadViewDidFinishLoad,nadViewManually:\(adView!)")
            
            // 広告のロードが終了してからViewを乗せる場合はnadViewDidFinishLoadを利用します。
            adView.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(nadViewManually)
            
            // 画面下部に広告を表示させる場合
            if #available(iOS 11.0, *) {
                view.addConstraints([
                    NSLayoutConstraint.init(item: adView!,
                                            attribute: .width,
                                            relatedBy: .equal,
                                            toItem: nil,
                                            attribute: .width,
                                            multiplier: 1,
                                            constant: adView.frame.size.width),
                    NSLayoutConstraint.init(item: adView!,
                                            attribute: .height,
                                            relatedBy: .equal,
                                            toItem: nil,
                                            attribute: .height,
                                            multiplier: 1,
                                            constant: adView.frame.size.height),
                    NSLayoutConstraint.init(item: adView!,
                                            attribute: .centerX,
                                            relatedBy: .equal,
                                            toItem: view,
                                            attribute: .centerX,
                                            multiplier: 1,
                                            constant: 0),
                    NSLayoutConstraint.init(item: adView!,
                                            attribute: .bottom,
                                            relatedBy: .equal,
                                            toItem: view.safeAreaLayoutGuide,
                                            attribute: .bottom,
                                            multiplier: 1,
                                            constant: 0),
                ])
            } else {
                // Fallback on earlier versions
                view.addConstraints([
                    NSLayoutConstraint.init(item: adView!,
                                            attribute: .width,
                                            relatedBy: .equal,
                                            toItem: nil,
                                            attribute: .width,
                                            multiplier: 1,
                                            constant: adView.frame.size.width),
                    NSLayoutConstraint.init(item: adView!,
                                            attribute: .height,
                                            relatedBy: .equal,
                                            toItem: nil,
                                            attribute: .height,
                                            multiplier: 1,
                                            constant: adView.frame.size.height),
                    NSLayoutConstraint.init(item: adView!,
                                            attribute: .centerX,
                                            relatedBy: .equal,
                                            toItem: view,
                                            attribute: .centerX,
                                            multiplier: 1,
                                            constant: 0),
                    NSLayoutConstraint.init(item: adView!,
                                            attribute: .bottom,
                                            relatedBy: .equal,
                                            toItem: bottomLayoutGuide,
                                            attribute: .top,
                                            multiplier: 1,
                                            constant: 0),
                ])
            }
        } else {
            
        }
    }
    
    // 以下は広告受信成功ごとに通知される任意メソッドです。
    func nadViewDidReceiveAd(_ adView: NADView!) {
        if (adView == bannerViewFromNib) {
            print("nadViewDidReceiveAd,bannerViewFromNib:\(adView!)")
        } else if (adView == nadViewManually) {
            print("nadViewDidReceiveAd,nadViewManually:\(adView!)")
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
        } else if (adView == nadViewManually) {
            print("nadViewDidFailToReceiveAd,nadViewManually,code=\(error.code)")
            print("nadViewDidFailToReceiveAd,nadViewManually,domain=\(error.domain)")
        } else {
            
        }
    }
    
    // 以下はバナー広告がクリックされるごとに通知される任意メソッドです。
    func nadViewDidClickAd(_ adView: NADView!) {
        if (adView == bannerViewFromNib) {
            print("nadViewDidClickAd,bannerViewFromNib:\(adView!)")
        } else if (adView == nadViewManually) {
            print("nadViewDidClickAd,nadViewManually:\(adView!)")
        } else {
            
        }
    }

    // 以下はインフォメーションボタンがクリックされるごとに通知される任意メソッドです。
    func nadViewDidClickInformation(_ adView: NADView!) {
        if (adView == bannerViewFromNib) {
            print("nadViewDidClickInformation,bannerViewFromNib:\(adView!)")
        } else if (adView == nadViewManually) {
            print("nadViewDidClickInformation,nadViewManually:\(adView!)")
        } else {
            
        }
    }
}
