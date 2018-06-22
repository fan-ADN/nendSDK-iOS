//
//  InFeedAdSource.swift
//  NendSDK_Swift_Sample
//
//  Copyright © 2018年 F@N Communications. All rights reserved.
//

import Foundation
import UIKit

protocol InFeedAdSource: class {
    
    var position: InFeedPosition { get }
    var loadedIndexPaths: [IndexPath] { get }
    
    func getReuseIdentifier(at indexPath: IndexPath) -> String
    func isManaged(at indexPath: IndexPath) -> Bool
    func isLoadCompleted(at indexPath: IndexPath) -> Bool
    func loadAd(at indexPath: IndexPath, requestCount: Int, completionHandler: @escaping (Bool) -> Void)
    func invalidateAdCache()
    func notifyAdPositionChanged()
    func renderer(in view: UIView, at indexPath: IndexPath)
    
}

private func _abstract() -> Never {
    fatalError("Method must be overridden")
}

class AbstractAdSource<T>: NSObject, InFeedAdSource {

    let adPosition = InFeedPosition()
    var cachedAds = [IndexPath: [T]]()
    
    var reuseIdentifierHandler: ((IndexPath) -> String)?
    var renderingHandler: ((UIView, IndexPath, [T]) -> Void)?
    
    var position: InFeedPosition {
        return adPosition
    }
    
    var loadedIndexPaths: [IndexPath] {
        return Array(cachedAds.keys)
    }
    
    func getReuseIdentifier(at indexPath: IndexPath) -> String {
        if let handler = reuseIdentifierHandler {
            return handler(indexPath)
        } else {
            return ""
        }
    }
    
    func isManaged(at indexPath: IndexPath) -> Bool {
        return adPosition.isAdRow(at: indexPath)
    }
    
    func isLoadCompleted(at indexPath: IndexPath) -> Bool {
        guard let ads = self[at: indexPath] else { return false }
        return ads.count == adPosition.numberOfAds(at: indexPath)
    }
    
    func invalidateAdCache() {
        cachedAds.removeAll()
    }
    
    func notifyAdPositionChanged() {
        var ads = cachedAds.reduce(into: [T]()) { $0 += $1.value }
        cachedAds = adPosition.allAdRowIndexPaths.reduce(into: [IndexPath: [T]]()) {
            if let adCount = adPosition.numberOfAds(at: $1), adCount <= ads.count {
                $0[$1] = Array(ads.prefix(adCount))
                ads.removeFirst(adCount)
            }
        }
    }
    
    func renderer(in view: UIView, at indexPath: IndexPath) {
        if let handler = renderingHandler, let ads = self[at: indexPath] {
            handler(view, indexPath, ads)
        }
    }
    
    func loadAd(at indexPath: IndexPath, requestCount: Int, completionHandler: @escaping (Bool) -> Void) {
        _abstract()
    }
    
    subscript(at indexPath: IndexPath) -> [T]? {
        get {
            return cachedAds[indexPath]
        }
    }
    
}
