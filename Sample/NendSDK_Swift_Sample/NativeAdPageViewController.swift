//
//  NativeAdPageViewController.swift
//  NendSDK_Sample
//
//  Copyright © 2015年 F@N Communications. All rights reserved.
//

import UIKit

class NativeAdPageViewController: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource, NADNativeDelegate {

    private let client: NADNativeClient = NADNativeClient(spotId: "485500", apiKey: "10d9088b5bd36cf43b295b0774e5dcf7d20a4071")
    private var contentViewControllers = [NativeAdPageContentViewController]()
    private var pageViewController: UIPageViewController!
    
    deinit {
        print("NativeAdPageViewController: deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "Pageable"
        
        self.pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        self.pageViewController.dataSource = self
        self.pageViewController.delegate = self
        self.pageViewController.view.frame = self.view.frame
        self.view.addSubview(self.pageViewController.view)
        
        NADNativeLogger.setLogLevel(.Warn)
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        // 4ページ分の広告を先にまとめて取得
        let group = dispatch_group_create()
        dispatch_apply(4, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { (i) -> Void in
            dispatch_group_enter(group)
            self.client.loadWithCompletionBlock({ (ad, _) -> Void in
                if let vc = self.storyboard!.instantiateViewControllerWithIdentifier("NativeAdPageContentViewController") as? NativeAdPageContentViewController {
                    ad.delegate = self;
                    vc.view.frame = self.view.frame
                    vc.ad = ad
                    vc.position = self.contentViewControllers.count + 1
                    self.contentViewControllers.append(vc)
                }
                dispatch_group_leave(group);
            })
        }
        dispatch_group_notify(group, dispatch_get_main_queue()) { () -> Void in
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            if 0 < self.contentViewControllers.count {
                self.pageViewController.setViewControllers([self.contentViewControllers.first!], direction: .Forward, animated: false, completion: nil)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UIPageViewControllerDataSource

    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        guard let index = self.contentViewControllers.indexOf(viewController as! NativeAdPageContentViewController) else {
            return nil
        }
        if 0 == index {
            return nil
        }
        return self.contentViewControllers[index - 1]
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        guard let index = self.contentViewControllers.indexOf(viewController as! NativeAdPageContentViewController) else {
            return nil
        }
        if self.contentViewControllers.count == index + 1 {
            return nil
        }
        return self.contentViewControllers[index + 1]
    }
    
    // MARK: - NADNativeDelegate
    
    func nadNativeDidClickAd(ad: NADNative!) {
        print("NativeAdPageViewController: nadNativeDidClickAd")
    }
}
