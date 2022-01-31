//
//  FullBoardView.swift
//  SwiftUI_Example
//
//  Copyright © 2022 FAN Communications. All rights reserved.
//

import SwiftUI
import NendAd

struct FullBoardView: View {
    
    // フルボード広告を制御するクラスを初期化時にインスタンス化
    let fullboardAdController = FullboardAdController()
    
    var body: some View {
        VStack{
            Spacer()
            //Loadボタン
            Button(action: {
                fullboardAdController.loadAd()
            }) {
                Text("Load")
            }
            Spacer()
            //Showボタン
            Button(action: {
                fullboardAdController.showAd()
            }) {
                Text("Show")
            }
            Spacer()
        }
    }
}

// フルボード広告を制御するクラス
class FullboardAdController: NSObject {
    
    // loaderを保持
    private let adLoader = NADFullBoardLoader(spotID: 485504, apiKey: "30fda4b3386e793a14b27bedb4dcd29f03d638e5")!
    
    // フルボード広告のインスタンス
    private var ad: NADFullBoard?
    
    // 広告ロード処理
    func loadAd() {
        adLoader.loadAd { [weak self] (ad: NADFullBoard?, error: NADFullBoardLoaderError) in
            guard let `self` = self else { return }
            if let fullBoardAd = ad {
                fullBoardAd.delegate = self
                // ロード完了した広告を保持する
                self.ad = fullBoardAd
            } else {
                switch (error) {
                case .failedAdRequest:
                    print("広告リクエストに失敗しました。")
                    break
                case .failedDownloadImage:
                    print("広告画像のダウンロードに失敗しました。")
                    break
                case .invalidAdSpaces:
                    print("フルボード広告で利用できない広告枠が指定されました。")
                    break
                default:
                    break
                }
            }
        }
    }
    
    // 広告表示
    func showAd() {
        if let ad = self.ad {
            // 広告ロード済みの場合に表示する
            ad.show(from: getFrontViewController())
        }
    }
    
    //広告の表示先となるViewControllerを返すメソッド
    private func getFrontViewController() -> UIViewController? {
        let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        
        let vc = keyWindow?.rootViewController
        guard let _vc = vc?.presentedViewController else {
            return vc
        }
        return _vc
    }
}


// MARK: - NADFullBoardDelegate
extension FullboardAdController: NADFullBoardDelegate {
    
    // 広告表示時に呼び出されます
    func nadFullBoardDidShowAd(_ ad: NADFullBoard!) {
        print(#function)
    }
    
    // 広告クリック時に呼び出されます
    func nadFullBoardDidClickAd(_ ad: NADFullBoard!) {
        print(#function)
    }
    
    // 広告クローズ時に呼び出されます
    func nadFullBoardDidDismissAd(_ ad: NADFullBoard!) {
        print(#function)
    }
}

struct FullBoardView_Previews: PreviewProvider {
    static var previews: some View {
        FullBoardView()
    }
}
