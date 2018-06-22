//
//  InFeedTableViewController.swift
//  NendSDK_Swift_Sample
//
//  Copyright © 2018年 F@N Communications. All rights reserved.
//

import UIKit
import NendAd

class LargeVideoAdCell: UITableViewCell {
    
    @IBOutlet weak var videoView: NADNativeVideoView!
    
    var videoAd: NADNativeVideo? {
        set { videoView.videoAd = newValue! }
        get { return nil }
    }
    
}

class NormalVideoAdCell: UITableViewCell {
    
    @IBOutlet weak var videoView: NADNativeVideoView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ctaButton: UIButton!
    
    var videoAd: NADNativeVideo? {
        set {
            guard let videoAd = newValue else { return }
            videoView.videoAd = videoAd
            descriptionLabel.text = videoAd.explanation
            ctaButton.layer.cornerRadius = 4.0
            ctaButton.layer.borderWidth = 1.0
            ctaButton.layer.borderColor = UIColor.blue.cgColor
            ctaButton.contentEdgeInsets = UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0)
            ctaButton.setTitle(videoAd.callToAction, for: .normal)
            videoAd.registerInteractionViews([ctaButton])
        }
        get { return nil }
    }
    
}

class NativeAdCell: UITableViewCell, NADNativeViewRendering {
    
    @IBOutlet weak var adImage: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var prLabel: UILabel!
    @IBOutlet weak var ctaLabel: UILabel!

    func prTextLabel() -> UILabel! {
        return prLabel
    }
    
    func adImageView() -> UIImageView! {
        return adImage
    }
    
    func longTextLabel() -> UILabel! {
        return contentLabel
    }
    
    func actionButtonTextLabel() -> UILabel! {
        return ctaLabel
    }
    
}

class LoadingCell: UITableViewCell {
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    func startAnimating() {
        indicator.startAnimating()
    }
    
}

class InFeedTableViewController: UITableViewController {

    private let controller = InFeedController()
    private var items = [String]()
    private let videoAdLoader = NADNativeVideoLoader(spotId: AdSpaces.videoNativeAdSpotId, apiKey: AdSpaces.videoNativeAdApiKey, clickAction: .LP)
    private var pendingReloadIndexPaths = [IndexPath]()
    private var topVideoAdSource: InReadVideoAd?
    
    private var isScroll = false
    private var scrolling: Bool {
        get {
            return isScroll
        }
        set {
            isScroll = newValue
            if !isScroll { batchReloadIndexPaths() }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Table"
        
        if #available(iOS 10.0, *) {
            tableView.prefetchDataSource = self
        }
        
        let refresh = UIRefreshControl()
        refreshControl = refresh
        refreshControl!.addTarget(self, action: #selector(self.refreshData), for: .valueChanged)
        
        let adLoader = NADNativeVideoLoader(spotId: AdSpaces.videoNativeAdSpotId, apiKey: AdSpaces.videoNativeAdApiKey)
        let centerVideoAd = InReadVideoAd(adLoader: adLoader)
        centerVideoAd.reuseIdentifierHandler = { _ in "NormalVideoAdCell" }
        centerVideoAd.renderingHandler = { [weak self] (cell, indexPath, ads) in
            guard let `self` = self, let videoAdCell = cell as? NormalVideoAdCell else { return }
            videoAdCell.videoView.rootViewController = self
            videoAdCell.videoAd = ads[0]
        }
        centerVideoAd.add(at: [IndexPath(row: 20, section: 0), IndexPath(row: 30, section: 0)])
        
        let adClient = NADNativeClient(spotId: "485500", apiKey: "10d9088b5bd36cf43b295b0774e5dcf7d20a4071")!
        let nativeAd = InFeedNativeAd(adClient: adClient)
        nativeAd.reuseIdentifierHandler = { _ in "NativeAdCell" }
        nativeAd.renderingHandler = { (cell, indexPath, ads) in
            if let nativeAdCell = cell as? NativeAdCell {
                ads[0].intoView(nativeAdCell, advertisingExplicitly: .AD)
            }
        }
        nativeAd.add(at: IndexPath(row: 10, section: 0))
        nativeAd.repeat(interval: 10, in: 0)
        
        controller.isExcludeNotReadyAdRows = false
        controller.registerAdSources([centerVideoAd, nativeAd])
        controller.delegate = self

        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        videoAdLoader.loadAd { [weak self] (ad: NADNativeVideo?, error: Error?) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            guard let `self` = self else { return }
            self.items += (1...50).map { "Item \($0)" }
            
            if let videoAd = ad {
                let topVideoAd = InReadVideoAd(adLoader: self.videoAdLoader)
                topVideoAd.reuseIdentifierHandler = { _ in "LargeVideoAdCell" }
                topVideoAd.renderingHandler = { (cell, indexPath, ads) in
                    if let videoAdCell = cell as? LargeVideoAdCell {
                        videoAdCell.videoAd = ads[0]
                    }
                }
                topVideoAd.add(at: IndexPath(row: 0, section: 0), prefetchedAd: videoAd)
                self.topVideoAdSource = topVideoAd
                self.controller.registerAdSource(topVideoAd)
            }
            
            self.controller.reload()
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc private func refreshData() {
        if controller.adSources.isEmpty { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if let videoAdSource = self.topVideoAdSource {
                self.controller.unregisterAdSource(videoAdSource)
            }
            self.controller.invalidateAllAdCaches()
            self.controller.reload()
            self.refreshControl!.endRefreshing()
            self.tableView.reloadData()
        }
    }

    private func batchReloadIndexPaths() {
        if pendingReloadIndexPaths.isEmpty { return }
        if let visibleIndexPaths = tableView.indexPathsForVisibleRows {
            let reloadIndexPaths = pendingReloadIndexPaths.filter { visibleIndexPaths.contains($0) }
            if reloadIndexPaths.count > 0 {
                tableView.beginUpdates()
                tableView.reloadRows(at: reloadIndexPaths, with: .fade)
                tableView.endUpdates()
            }
        }
        pendingReloadIndexPaths.removeAll()
    }
    
    @IBAction func onValueChahed(sender: UISegmentedControl) {
        controller.isExcludeNotReadyAdRows = sender.selectedSegmentIndex == 1
        controller.reload()
        tableView.reloadData()
    }
    
}

// MARK: - UITableViewDelegate & UITableViewDataSource

extension InFeedTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count + controller.numberOfAdRows(in: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if controller.isAdRow(at: indexPath) {
            let adSource = controller[at: indexPath]!
            if adSource.isLoadCompleted(at: indexPath) {
                let cell = tableView.dequeueReusableCell(withIdentifier: adSource.getReuseIdentifier(at: indexPath), for: indexPath)
                adSource.renderer(in: cell, at: indexPath)
                return cell
            } else {
                controller.loadAds(at: indexPath)
                if !controller.isExcludeNotReadyAdRows {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath)
                    if let loadingCell = cell as? LoadingCell {
                        loadingCell.startAnimating()
                    }
                    return cell
                }
            }
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let originalIndexPath = controller.getOriginalIndexPath(from: indexPath)
        cell.textLabel!.text = items[originalIndexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// MARK: - UITableViewDataSourcePrefetching

extension InFeedTableViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if controller.isAdRow(at: indexPath), controller.isLoadCompleted(at: indexPath)! == false {
                controller.loadAds(at: indexPath)
            }
        }
    }
    
}

// MARK: - Scroll

extension InFeedTableViewController {
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.scrolling = true
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate { self.scrolling = false }
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.scrolling = false
    }
    
}

// MARK: - InFeedController.Delegate

extension InFeedTableViewController : Delegate {

    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfItems(inSection section: Int) -> Int {
        return items.count
    }
    
    func controller(_ controller: InFeedController, didLoadAdAtIndexPath indexPath: IndexPath) {
        print("\(#function): \(indexPath)")
        if controller.isExcludeNotReadyAdRows {
            var animation: UITableViewRowAnimation
            if let visibleIndexPaths = tableView.indexPathsForVisibleRows, visibleIndexPaths.contains(indexPath) {
                animation = .right
            } else {
                animation = .none
            }
            tableView.insertRows(at: [indexPath], with: animation)
        } else {
            if !self.scrolling {
                if let visibleIndexPaths = tableView.indexPathsForVisibleRows, visibleIndexPaths.contains(indexPath) {
                    tableView.reloadRows(at: [indexPath], with: .fade)
                }
            } else {
                pendingReloadIndexPaths.append(indexPath)
            }
        }
    }
    
    func controller(_ controller: InFeedController, didFailToLoadAdAtIndexPath indexPath: IndexPath) {
        print("\(#function): \(indexPath)")
        guard let adSource = controller[at: indexPath], !controller.isExcludeNotReadyAdRows else { return }
        var changed = false
        switch adSource {
        case let videoAd as InReadVideoAd:
            videoAd.remove(at: indexPath)
            changed = true
        case let nativeAd as InFeedNativeAd:
            if indexPath.row == 10 {
                nativeAd.remove(at: indexPath)
                changed = true
            }
        default:
            print("unknown ad souce.")
        }
        
        if changed {
            controller.reload()
            var animation: UITableViewRowAnimation
            if let visibleIndexPaths = tableView.indexPathsForVisibleRows, visibleIndexPaths.contains(indexPath) {
                animation = .left
            } else {
                animation = .none
            }
            tableView.deleteRows(at: [indexPath], with: animation)
        }
    }

}
