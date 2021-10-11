//
//  VideoNativePageViewController.swift
//  Swift_Example
//
//  Copyright © 2018年 FAN Communications. All rights reserved.
//

import UIKit
import NendAd

class VideoNativePageContentViewController: UIViewController {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var videoView: NADNativeVideoView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var callToActionButton: UIButton!
    
    var videoAd: NADNativeVideo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let ad = videoAd else { return }
        logoImageView.image = ad.logoImage
        titleLabel.text = ad.title
        videoView.videoAd = ad
        descriptionLabel.text = ad.explanation
        callToActionButton.setTitle(ad.callToAction, for: .normal)
        ad.registerInteractionViews([callToActionButton])
    }
    
}

class VideoNativePageViewController: UIPageViewController {

    private let adLoader = NADNativeVideoLoader(spotID: AdSpaces.videoNativeAdSpotId, apiKey: AdSpaces.videoNativeAdApiKey, clickAction: .LP)
    private var contentViewControllers = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        title = "Page"
        dataSource = self
        
        let externalStoryboard = UIStoryboard(name: "Fullboard", bundle: nil)
        for i in 0..<4 {
            if let content = externalStoryboard.instantiateViewController(withIdentifier: "FullBoardPageContent") as? FullBoardAdContentViewController {
                content.number = "\(i + 1)"
                contentViewControllers.append(content)
            }
        }
        if 0 < self.contentViewControllers.count {
            setViewControllers([self.contentViewControllers[0]], direction: .forward, animated: false, completion: nil)
        }
        
        adLoader.loadAd { [weak self] (ad, error) in
            guard let `self` = self, let videoAd = ad,
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "VideoNativePageContentViewController") as? VideoNativePageContentViewController else { return }
            vc.videoAd = videoAd
            self.contentViewControllers.insert(vc, at: 2)
        }
    }
    
}

extension VideoNativePageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = self.contentViewControllers.firstIndex(of: viewController), index > 0 else { return nil }
        return self.contentViewControllers[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = self.contentViewControllers.firstIndex(of: viewController), index < self.contentViewControllers.count - 1 else { return nil }
        return self.contentViewControllers[index + 1]
    }
    
}
