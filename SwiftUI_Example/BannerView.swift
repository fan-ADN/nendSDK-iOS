//
//  BannerView.swift
//  SwiftUI_Example
//
//  Copyright © 2021 FAN Communications. All rights reserved.
//

import SwiftUI
import NendAd

struct BannerView: View {
    
    var body: some View {
        VStack{
            BannerViewWrapper()
                .frame(width: 320, height: 50)
            Spacer()
            BannerViewWrapper()
                .frame(width: 320, height: 50)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct BannerViewWrapper : UIViewRepresentable {
    
    var bannerAdView = BannerAdView()
    
    func makeUIView(context: Context) -> some UIView {
        return bannerAdView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}


class BannerAdView: UIView, NADViewDelegate {
    
    var nadView: NADView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // NADViewクラスを生成
        nadView = NADView(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        // 広告枠のspotIDとapiKeyを設定(必須)
        nadView.setNendID(3172, apiKey: "a6eca9dd074372c898dd1df549301f277c53f2b9")
        // delegateを受けるオブジェクトを指定(必須)
        nadView.delegate = self
        // 読み込み開始(必須)
        nadView.load()
        // 通知有無にかかわらずViewに乗せる場合
        self.addSubview(nadView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - NADViewDelegate
    // 広告の受信に成功し表示できた場合に１度通知されます。必須メソッドです。
    func nadViewDidFinishLoad(_ adView: NADView!) {
        print("nadViewDidFinishLoad,nadViewManually:\(adView!)")
    }
    
    // 以下は広告受信成功ごとに通知される任意メソッドです。
    func nadViewDidReceiveAd(_ adView: NADView!) {
        print("nadViewDidReceiveAd,nadViewManually:\(adView!)")
    }
    
    // 以下は広告受信失敗ごとに通知される任意メソッドです。
    func nadViewDidFail(toReceiveAd adView: NADView!) {
        
        // エラーごとに処理を分岐する
        let error: NSError = adView.error as NSError
        
        switch (error.code) {
        case NADViewErrorCode.NADVIEW_AD_SIZE_TOO_LARGE.rawValue:
            // 広告サイズがディスプレイサイズよりも大きい
            break
        case NADViewErrorCode.NADVIEW_INVALID_RESPONSE_TYPE.rawValue:
            // 不明な広告ビュータイプ
            break
        case NADViewErrorCode.NADVIEW_FAILED_AD_REQUEST.rawValue:
            // 広告取得失敗
            break
        case NADViewErrorCode.NADVIEW_FAILED_AD_DOWNLOAD.rawValue:
            // 広告画像の取得失敗
            break
        case NADViewErrorCode.NADVIEW_AD_SIZE_DIFFERENCES.rawValue:
            // リクエストしたサイズと取得したサイズが異なる
            break
        default:
            break
        }
        
        // エラー発生時の情報をログに出力します
        print("nadViewDidFailToReceiveAd,nadViewManually,code=\(error.code)")
        print("nadViewDidFailToReceiveAd,nadViewManually,domain=\(error.domain)")
    }
    
    // 以下はバナー広告がクリックされるごとに通知される任意メソッドです。
    func nadViewDidClickAd(_ adView: NADView!) {
        print("nadViewDidClickAd,nadViewManually:\(adView!)")
    }
    
    // 以下はインフォメーションボタンがクリックされるごとに通知される任意メソッドです。
    func nadViewDidClickInformation(_ adView: NADView!) {
        print("nadViewDidClickInformation,nadViewManually:\(adView!)")
    }
    
}

struct NendBannerView_Previews : PreviewProvider {
    static var previews: some View {
        BannerView()
    }
}
