//
//  InFeedNativeAd.swift
//  Swift_Example
//
//  Copyright © 2018年 FAN Communications. All rights reserved.
//

import Foundation
import NendAd

class InFeedNativeAd: AbstractAdSource<NADNative> {
    
    private let adClient: NADNativeClient
    
    init(adClient: NADNativeClient) {
        self.adClient = adClient
    }
    
    func add(at indexPath: IndexPath, fillInRow: Bool = true, adCount: Int = 1) {
        adPosition.add(at: indexPath, fillInRow: fillInRow, adCount: adCount)
    }
    
    func remove(at indexPath: IndexPath) {
        adPosition.remove(at: indexPath)
    }
    
    func `repeat`(interval: Int, in section: Int, fillInRow: Bool = true, adCount: Int = 1) {
        adPosition.`repeat`(interval: interval, in: section, fillInRow: fillInRow, adCount: adCount)
    }
    
    func removeRepeatInterval(in section: Int) {
        adPosition.removeRepeatInterval(in: section)
    }
    
    override func loadAd(at indexPath: IndexPath, requestCount: Int, completionHandler: @escaping (Bool) -> Void) {
        var nativeAds = [NADNative]()
        let group = DispatchGroup()
        
        for _ in 0..<requestCount {
            group.enter()
            adClient.load { (ad, error) in
                if let nativeAd = ad { nativeAds.append(nativeAd) }
                group.leave()
            }
        }
        
        group.notify(queue: DispatchQueue.main) {
            if requestCount == nativeAds.count {
                self.cachedAds[indexPath] = nativeAds
                completionHandler(true)
            } else {
                completionHandler(false)
            }
        }
    }

}
