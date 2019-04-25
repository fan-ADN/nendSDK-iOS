//
//  InFeedController.swift
//  NendSDK_Swift_Sample
//
//  Copyright © 2018年 F@N Communications. All rights reserved.
//

import Foundation

protocol Delegate: class {
    func numberOfSections() -> Int
    func numberOfItems(inSection section: Int) -> Int
    func controller(_ controller: InFeedController, didLoadAdAtIndexPath indexPath: IndexPath)
    func controller(_ controller: InFeedController, didFailToLoadAdAtIndexPath indexPath: IndexPath)
}

class InFeedController: NSObject {

    private var adPosition: InFeedPosition?
    private var loadingIndexPaths = [IndexPath]()
    private(set) var adSources = [InFeedAdSource]()

    weak var delegate: Delegate?
    
    private var excludeNotReadyAdRows = false
    var isExcludeNotReadyAdRows: Bool {
        set {
            excludeNotReadyAdRows = newValue
            adPosition?.isExcludeNotReadyAdRows = newValue
        }
        get {
            return excludeNotReadyAdRows
        }
    }
    
    subscript(at indexPath: IndexPath) -> InFeedAdSource? {
        get {
            return adSources.first { $0.isManaged(at: indexPath) }
        }
    }
    
    func registerAdSource(_ source: InFeedAdSource) {
        adSources.append(source)
    }

    func registerAdSources(_ source: [InFeedAdSource]) {
        adSources.append(contentsOf: source)
    }
    
    @discardableResult
    func unregisterAdSource(_ source: InFeedAdSource) -> Bool {
        if let index = adSources.firstIndex(where: { $0 === source }) {
            adSources.remove(at: index)
            return true
        } else {
            return false
        }
    }

    func isAdRow(at indexPath: IndexPath) -> Bool {
        return adPosition?.isAdRow(at: indexPath) ?? false
    }
    
    func isLoadCompleted(at indexPath: IndexPath) -> Bool? {
        return self[at: indexPath]?.isLoadCompleted(at: indexPath)
    }
    
    func loadAds(at indexPath: IndexPath) {
        guard let adPosition = self.adPosition,
            let adSource = self[at: indexPath],
            let requiredAdCount = adPosition.numberOfAds(at: indexPath),
            !loadingIndexPaths.contains(indexPath) else { return }
        
        if adSource.isLoadCompleted(at: indexPath) {
            delegate?.controller(self, didLoadAdAtIndexPath: indexPath)
            return
        }
        loadingIndexPaths.append(indexPath)
        adSource.loadAd(at: indexPath, requestCount: requiredAdCount) { [weak self] (completed: Bool) in
            guard let `self` = self else { return }
            if let index = self.loadingIndexPaths.firstIndex(of: indexPath) { self.loadingIndexPaths.remove(at: index) }
            if (completed) {
                adPosition.notifyAdLoaded(at: [indexPath])
                self.delegate?.controller(self, didLoadAdAtIndexPath: indexPath)
            } else {
                self.delegate?.controller(self, didFailToLoadAdAtIndexPath: indexPath)
            }
        }
    }
    
    func invalidateAdCache(with adSource: InFeedAdSource) {
        let loadedIndexPaths = adSource.loadedIndexPaths
        adSource.invalidateAdCache()
        adPosition?.notifyAdDiscarded(at: loadedIndexPaths)
    }
    
    func invalidateAllAdCaches() {
        adSources.forEach { invalidateAdCache(with: $0) }
    }
    
    func numberOfAdRows(in section: Int) -> Int {
        guard let adPosition = self.adPosition else { return 0 }
        return adPosition.numberOfAdItems(in: section)
    }
    
    func reload() {
        guard let delegate = delegate, adSources.count > 0 else { return }
        let adPosition = InFeedPosition.merge(adSources.map { $0.position } )
        adPosition.isExcludeNotReadyAdRows = isExcludeNotReadyAdRows
        let sections = delegate.numberOfSections()
        for i in 0..<sections {
            adPosition.setup(in: i, itemCount: delegate.numberOfItems(inSection: i))
        }
        for adSource in adSources {
            adSource.notifyAdPositionChanged()
            adPosition.notifyAdLoaded(at: adSource.loadedIndexPaths)
        }
        self.adPosition = adPosition
    }
    
}

extension InFeedController {
    
    func getOriginalIndexPath(from actualIndexPath: IndexPath) -> IndexPath {
        if let position = adPosition {
            return position.getOriginalIndexPath(from: actualIndexPath)
        } else {
            return actualIndexPath
        }
    }
    
}
