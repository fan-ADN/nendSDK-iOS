//
//  InReadVideoAd.swift
//  NendSDK_Swift_Sample
//
//  Copyright © 2018年 F@N Communications. All rights reserved.
//

import Foundation
import NendAd

class InReadVideoAd: AbstractAdSource<NADNativeVideo> {
    
    private let adLoader: NADNativeVideoLoader
    
    init(adLoader: NADNativeVideoLoader) {
        self.adLoader = adLoader
    }
    
    func add(at indexPath: IndexPath, prefetchedAd videoAd: NADNativeVideo) {
        cachedAds[indexPath] = [videoAd]
        adPosition.add(at: indexPath)
    }
    
    func add(at indexPaths: [IndexPath]) {
        indexPaths.forEach { adPosition.add(at: $0) }
    }
    
    func remove(at indexPath: IndexPath) {
        adPosition.remove(at: indexPath)
    }
    
    override func loadAd(at indexPath: IndexPath, requestCount: Int, completionHandler: @escaping (Bool) -> Void) {
        adLoader.loadAd { (ad, error) in
            if let videoAd = ad {
                self.cachedAds[indexPath] = [videoAd]
                completionHandler(true)
            } else {
                completionHandler(false)
            }
        }
    }

}
