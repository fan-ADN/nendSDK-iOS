//
//  Util.swift
//  SwiftUI_Example
//
//  Copyright © 2022 F@N Communications. All rights reserved.
//

import Foundation
import SwiftUI

class Util {
    //広告の表示先となるViewControllerを返すメソッド
    class func getFrontViewController() -> UIViewController? {
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
