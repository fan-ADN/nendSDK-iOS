//
//  NativeAdPageViewController.swift
//  ObjC_Example
//
//  Copyright © 2015年 FAN Communications. All rights reserved.
//

import UIKit
import NendAd

class NativeAdPageViewController: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource, NADNativeDelegate {

    fileprivate let client: NADNativeClient = NADNativeClient(spotID: 485500, apiKey: "10d9088b5bd36cf43b295b0774e5dcf7d20a4071")
    fileprivate var contentViewControllers = [NativeAdPageContentViewController]()
    fileprivate var pageViewController: UIPageViewController!
    
    deinit {
        print("NativeAdPageViewController: deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "Pageable"
        
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.pageViewController.dataSource = self
        self.pageViewController.delegate = self
        self.pageViewController.view.frame = self.view.frame
        self.view.addSubview(self.pageViewController.view)
        
        // 4ページ分の広告を先にまとめて取得
        let group = DispatchGroup()
        DispatchQueue.concurrentPerform(iterations: 4) { (i) -> Void in
            group.enter()
            self.client.load(completionBlock: { (ad, _) -> Void in
                if let vc = self.storyboard!.instantiateViewController(withIdentifier: "NativeAdPageContentViewController") as? NativeAdPageContentViewController {
                    ad?.delegate = self;
                    vc.view.frame = self.view.frame
                    vc.ad = ad
                    vc.position = self.contentViewControllers.count + 1
                    self.contentViewControllers.append(vc)
                }
                group.leave();
            })
        }
        group.notify(queue: DispatchQueue.main) { () -> Void in
            if 0 < self.contentViewControllers.count {
                self.pageViewController.setViewControllers([self.contentViewControllers.first!], direction: .forward, animated: false, completion: nil)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UIPageViewControllerDataSource

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = self.contentViewControllers.firstIndex(of: viewController as! NativeAdPageContentViewController) else {
            return nil
        }
        if 0 == index {
            return nil
        }
        return self.contentViewControllers[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = self.contentViewControllers.firstIndex(of: viewController as! NativeAdPageContentViewController) else {
            return nil
        }
        if self.contentViewControllers.count == index + 1 {
            return nil
        }
        return self.contentViewControllers[index + 1]
    }
    
    // MARK: - NADNativeDelegate
    
    func nadNativeDidClickAd(_ ad: NADNative!) {
        print("NativeAdPageViewController: nadNativeDidClickAd")
    }
}
