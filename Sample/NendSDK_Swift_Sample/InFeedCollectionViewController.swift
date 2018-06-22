//
//  InFeedCollectionViewController.swift
//  NendSDK_Swift_Sample
//
//  Copyright © 2018年 F@N Communications. All rights reserved.
//

import UIKit
import NendAd

private let reuseIdentifier = "Cell"

class LoadingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    func startAnimating() {
        indicator.startAnimating()
    }
    
}

class VideoAdCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var videoView: NADNativeVideoView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ctaButton: UIButton!
    
    var videoAd: NADNativeVideo? {
        set {
            guard let videoAd = newValue else { return }
            videoView.videoAd = videoAd
            titleLabel.text = videoAd.title
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

class NativeAdCollectionViewCell: UICollectionViewCell, NADNativeViewRendering {
    
    @IBOutlet weak var adImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var prLabel: UILabel!
    
    func prTextLabel() -> UILabel! {
        return prLabel
    }
    
    func adImageView() -> UIImageView! {
        return adImage
    }
    
    func shortTextLabel() -> UILabel! {
        return titleLabel
    }
    
}

class InFeedCollectionViewController: UICollectionViewController {

    private var items: [UIColor]!
    private let controller = InFeedController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        title = "Collection"
        
        if #available(iOS 10.0, *) {
            collectionView?.prefetchDataSource = self
        }
        
        items = Array(repeating: [UIColor.red, UIColor.green, UIColor.blue], count: 10).reduce(into: [UIColor]()) { $0.append(contentsOf: $1) }
        
        let adLoader = NADNativeVideoLoader(spotId: AdSpaces.videoNativeAdSpotId, apiKey: AdSpaces.videoNativeAdApiKey)
        let inRead = InReadVideoAd(adLoader: adLoader)
        inRead.reuseIdentifierHandler = { _ in "VideoAdCell" }
        inRead.renderingHandler = { [weak self] (cell, indexPath, ads) in
            guard let `self` = self, let videoAdCell = cell as? VideoAdCollectionViewCell else { return }
            videoAdCell.videoView.rootViewController = self
            videoAdCell.videoAd = ads[0]
        }
        inRead.add(at: [IndexPath(row: 10, section: 0)])
        
        let adClient = NADNativeClient(spotId: "485504", apiKey: "30fda4b3386e793a14b27bedb4dcd29f03d638e5")!
        let inFeed = InFeedNativeAd(adClient: adClient)
        inFeed.reuseIdentifierHandler = { _ in "NativeAdCell" }
        inFeed.renderingHandler = { (cell, indexPath, ads) in
            if let nativeAdCell = cell as? NativeAdCollectionViewCell {
                ads[0].intoView(nativeAdCell, advertisingExplicitly: .sponsored)
            }
        }
        inFeed.add(at: IndexPath(row: 5, section: 0))
        inFeed.add(at: IndexPath(row: 25, section: 0))
        
        controller.registerAdSources([inFeed, inRead])
        controller.isExcludeNotReadyAdRows = false
        controller.delegate = self
        controller.reload()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource

extension InFeedCollectionViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count + controller.numberOfAdRows(in: section)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if controller.isAdRow(at: indexPath) {
            let adSource = controller[at: indexPath]!
            if adSource.isLoadCompleted(at: indexPath) {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: adSource.getReuseIdentifier(at: indexPath), for: indexPath)
                cell.contentView.layer.borderWidth = 1.0
                cell.contentView.layer.borderColor = UIColor.darkGray.cgColor
                adSource.renderer(in: cell, at: indexPath)
                return cell
            } else {
                controller.loadAds(at: indexPath)
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LoadingCell", for: indexPath)
                if let loadingCell = cell as? LoadingCollectionViewCell {
                    loadingCell.startAnimating()
                }
                return cell
            }
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
            let originalIndexPath = controller.getOriginalIndexPath(from: indexPath)
            cell.contentView.backgroundColor = self.items[originalIndexPath.row]
            return cell
        }
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension InFeedCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(8.0, 8.0, 8.0, 8.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = self.view.bounds.size.width / 2 - 16.0
        return CGSize(width: size, height: size)
    }

}

// MARK: - UICollectionViewDataSourcePrefetching

extension InFeedCollectionViewController: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if controller.isAdRow(at: indexPath), controller.isLoadCompleted(at: indexPath)! == false {
                controller.loadAds(at: indexPath)
            }
        }
    }
    
}

// MARK: - InFeedController.Delegate

extension InFeedCollectionViewController: Delegate {
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfItems(inSection section: Int) -> Int {
        return items.count
    }
    
    func controller(_ controller: InFeedController, didLoadAdAtIndexPath indexPath: IndexPath) {
        print("\(#function): \(indexPath)")
        collectionView?.reloadItems(at: [indexPath])
    }
    
    func controller(_ controller: InFeedController, didFailToLoadAdAtIndexPath indexPath: IndexPath) {
        print("\(#function): \(indexPath)")
    }
    
}
