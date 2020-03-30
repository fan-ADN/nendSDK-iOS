//
//  InFeedPosition.swift
//  Swift_Example
//
//  Copyright © 2018年 FAN Communications. All rights reserved.
//

import Foundation

class InFeedPosition: NSObject {
    
    private struct Data: Equatable, Comparable {
        
        let indexPath: IndexPath?
        let repeatInterval: Int?
        let isFillInRow: Bool
        let adCount: Int
        weak var positionSource: InFeedPosition?
        
        init(indexPath: IndexPath? = nil, repeatInterval: Int? = nil, isFillInRow: Bool = true, adCount: Int = 1, position: InFeedPosition) {
            self.indexPath = indexPath
            self.repeatInterval = repeatInterval
            self.isFillInRow = isFillInRow
            self.adCount = adCount
            self.positionSource = position
        }
        
        static func == (lhs: Data, rhs: Data) -> Bool {
            if let indexPath1 = lhs.indexPath, let indexPath2 = rhs.indexPath {
                return indexPath1 == indexPath2
            } else {
                fatalError()
            }
        }
        
        static func < (lhs: Data, rhs: Data) -> Bool {
            if let indexPath1 = lhs.indexPath, let indexPath2 = rhs.indexPath {
                return indexPath1 < indexPath2
            } else {
                fatalError()
            }
        }
        
    }
    
    typealias Section = Int

    private var fixedPositions = [Section: [Data]]()
    private var repeatIntervals = [Section: Data]()
    private var adIndexPaths = [Section: [IndexPath]]()
    private var adCounts = [IndexPath: Int]()
    private var loadCompletedAdIndexPaths = Set<IndexPath>()
    
    var isExcludeNotReadyAdRows = false

    var allAdRowIndexPaths: [IndexPath] {
        return adIndexPaths.reduce(into: [IndexPath]()) { $0 += $1.value }
    }

    private let indexPathComparator = { (lhs: Any, rhs: Any) -> ComparisonResult in
        if let indexPath1 = lhs as? IndexPath, let indexPath2 = rhs as? IndexPath {
            return indexPath1.compare(indexPath2)
        } else {
            fatalError()
        }
    }

    func add(at indexPath: IndexPath, fillInRow: Bool = true, adCount: Int = 1, position: InFeedPosition? = nil) {
        var fixedPositionDatas = fixedPositions.removeValue(forKey: indexPath.section) ?? []
        fixedPositionDatas.append(Data(indexPath: indexPath, isFillInRow: fillInRow, adCount: adCount, position: position ?? self))
        fixedPositions[indexPath.section] = fixedPositionDatas
    }
    
    func remove(at indexPath: IndexPath) {
        if var fixedPositionDatas = fixedPositions.removeValue(forKey: indexPath.section) {
            if let data = fixedPositionDatas.first(where: { $0.indexPath == indexPath }), let index = fixedPositionDatas.firstIndex(of: data) {
                fixedPositionDatas.remove(at: index)
                fixedPositions[indexPath.section] = fixedPositionDatas
            }
        }
    }
    
    func `repeat`(interval: Int, in section: Int, fillInRow: Bool = true, adCount: Int = 1, position: InFeedPosition? = nil) {
        repeatIntervals[section] = Data(repeatInterval: interval, isFillInRow: fillInRow, adCount: adCount, position: position ?? self)
    }
    
    func removeRepeatInterval(in section: Int) {
        repeatIntervals.removeValue(forKey: section)
    }
    
    func isAdRow(at indexPath: IndexPath) -> Bool {
        if let indexPaths = adIndexPaths[indexPath.section], indexPaths.count > 0 {
            return index(of: indexPath, array: indexPaths, options: .firstEqual) != NSNotFound
        } else {
            return false
        }
    }
    
    func setup(in section: Int, itemCount count: Int) {
        var indexPaths = adIndexPaths.removeValue(forKey: section) ?? []
        if indexPaths.count > 0 {
            indexPaths.removeAll()
        }
        
        Array(adCounts.keys).filter { $0.section == section }.forEach { (indexPath: IndexPath) -> Void in
            adCounts.removeValue(forKey: indexPath)
        }
        
        if count == 0 || !hasPositions { return }
        
        var totalCount = count
        var positionMap = [InFeedPosition: [IndexPath]]()
        var beginRepeatIndex = -1
 
        if var fixedPositionDatas = fixedPositions[section] {
            fixedPositionDatas.sort()
            beginRepeatIndex = fixedPositionDatas.last!.indexPath!.row
            for data in fixedPositionDatas {
                let indexPath = data.indexPath!
                if data.isFillInRow ? count >= indexPath.row : count > indexPath.row {
                    indexPaths.append(indexPath)
                    if data.isFillInRow { totalCount += 1 }
                    adCounts[indexPath] = data.adCount
                    if let positionSource = data.positionSource, positionSource != self {
                        var array = positionMap.removeValue(forKey: positionSource) ?? []
                        array.append(indexPath)
                        positionMap[positionSource] = array
                    }
                } else {
                    break
                }
            }
        }
        
        if let repeatIntervalData = repeatIntervals[section] {
            var repeatCount = 1
            while true {
                let index = beginRepeatIndex + repeatIntervalData.repeatInterval! * repeatCount
                if index >= totalCount { break }
                let indexPath = IndexPath(row: index, section: section)
                indexPaths.append(indexPath)
                if repeatIntervalData.isFillInRow { totalCount += 1 }
                adCounts[indexPath] = repeatIntervalData.adCount
                repeatCount += 1
                if let positionSource = repeatIntervalData.positionSource, positionSource != self {
                    var array = positionMap.removeValue(forKey: positionSource) ?? []
                    array.append(indexPath)
                    positionMap[positionSource] = array
                }
            }
        }
        
        indexPaths.sort()
        adIndexPaths[section] = indexPaths
        
        for (position, indexPaths) in positionMap {
            position.notify(adPositions: indexPaths, in: section)
            for indexPath in indexPaths {
                position.notify(adCount: adCounts[indexPath]!, at: indexPath)
            }
        }
        
        print("ad index paths: \(adIndexPaths[section]!)")
    }
    
    func notifyAdLoaded(at indexPaths: [IndexPath]) {
        indexPaths.forEach { loadCompletedAdIndexPaths.insert($0) }
    }
    
    func notifyAdDiscarded(at indexPaths: [IndexPath]) {
        indexPaths.forEach { loadCompletedAdIndexPaths.remove($0) } 
    }
    
    func getAdIndexPaths(in section: Int) -> [IndexPath]? {
        guard let indexPaths = adIndexPaths[section] else { return nil }
        if isExcludeNotReadyAdRows {
            return Array(loadCompletedAdIndexPaths.intersection(indexPaths)).sorted()
        } else {
            return indexPaths
        }
    }
    
    func numberOfAdItems(in section: Int) -> Int {
        return getAdIndexPaths(in: section)?.count ?? 0
    }
    
    func numberOfAds(at indexPath: IndexPath) -> Int? {
        return adCounts[indexPath]
    }
    
    func getOriginalIndexPath(from actualIndexPath: IndexPath) -> IndexPath {
        if let indexPaths = getAdIndexPaths(in: actualIndexPath.section) {
            if index(of: actualIndexPath, array: indexPaths, options: .firstEqual) != NSNotFound {
                return actualIndexPath
            } else {
                let adCount = index(of: actualIndexPath, array: indexPaths, options: [.insertionIndex, .lastEqual])
                return IndexPath(row: actualIndexPath.row - adCount, section: actualIndexPath.section)
            }
        } else {
            return actualIndexPath
        }
    }
    
}

extension InFeedPosition {
    
    class func merge(_ positions: [InFeedPosition]) -> InFeedPosition {
        if positions.count == 1 { return positions[0] }
        let mergedPosition = InFeedPosition()
        for position in positions {
            for (_, datas) in position.fixedPositions {
                for data in datas {
                    mergedPosition.add(at: data.indexPath!, fillInRow: data.isFillInRow, adCount: data.adCount, position: position)
                }
            }
            for (section, data) in position.repeatIntervals {
                mergedPosition.repeat(interval: data.repeatInterval!, in: section, fillInRow: data.isFillInRow, adCount: data.adCount, position: position)
            }
        }
        return mergedPosition
    }
    
    private func notify(adPositions positions: [IndexPath], in section: Int) {
        var indexPaths = adIndexPaths.removeValue(forKey: section) ?? []
        if indexPaths.count > 0 { indexPaths.removeAll() }
        indexPaths.append(contentsOf: positions)
        adIndexPaths[section] = indexPaths
    }
    
    private func notify(adCount count: Int, at indexPath: IndexPath) {
        adCounts[indexPath] = count
    }
    
    private var hasPositions: Bool {
        return fixedPositions.count > 0 || repeatIntervals.count > 0
    }

    private func index(of indexPath: IndexPath, array: [IndexPath], options: NSBinarySearchingOptions) -> Int {
        let nsArray = NSArray(array: array)
        return nsArray.index(of: indexPath, inSortedRange: NSMakeRange(0, nsArray.count), options: options, usingComparator: indexPathComparator)
    }
    
}

