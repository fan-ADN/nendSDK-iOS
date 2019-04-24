//
//  FullBoardTabPageViewController.swift
//  NendSDK_Sample
//
//  Copyright © 2017年 F@N Communications. All rights reserved.
//

import UIKit
import NendAd

class FullBoardTabPageViewController: UIViewController {

    @IBOutlet fileprivate weak var indicator: UIView!
    @IBOutlet fileprivate weak var tabContainer: UIView!
    @IBOutlet fileprivate var indicatorLeadingConstraint: NSLayoutConstraint!
    
    private var loader: NADFullBoardLoader!
    fileprivate var contentViewControllers: [UIViewController]!
    
    fileprivate var currentTabIndex: Int = 0 {
        didSet {
            guard oldValue != self.currentTabIndex,
                let currentTab = self.tabContainer.viewWithTag(oldValue) as? UIButton,
                let nextTab = self.tabContainer.viewWithTag(self.currentTabIndex) as? UIButton else {
                return
            }
            currentTab.isSelected = false
            nextTab.isSelected = true
            
            self.view.layoutIfNeeded()
            self.indicatorLeadingConstraint.constant = nextTab.frame.origin.x
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    private var pageViewController: UIPageViewController {
        return self.children.first as! UIPageViewController
    }
    
    private var currentTabItem: UIButton? {
        return self.tabContainer.subviews.compactMap({ $0 as? UIButton }).filter({ $0.isSelected }).first
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        self.title = "Tab"

        self.indicator.isHidden = true
        self.tabContainer.isHidden = true
        
        self.pageViewController.dataSource = self
        self.pageViewController.delegate = self
        
        self.loader = NADFullBoardLoader(spotId: "485504", apiKey: "30fda4b3386e793a14b27bedb4dcd29f03d638e5")
        self.loader.loadAd { [weak self] (fullBoardAd, error) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            guard let `self` = self, let ad = fullBoardAd else {
                return
            }
            
            self.indicator.isHidden = false
            self.tabContainer.isHidden = false
            (self.tabContainer.subviews.first as! UIButton).isSelected = true
            
            self.contentViewControllers = Array(arrayLiteral: TableViewController(), TableViewController(), ad.fullBoardAdViewController())
            self.pageViewController.setViewControllers(
                [self.contentViewControllers[0]], direction: .forward, animated: false, completion: nil)
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        guard let currentTab = self.currentTabItem else {
            return
        }
        coordinator.animate(alongsideTransition: nil, completion: { (_) in
            self.indicatorLeadingConstraint.constant = currentTab.frame.origin.x
            self.view.layoutIfNeeded()
        })
    }
    
    @IBAction fileprivate func onTapTabItem(_ button: UIButton) {
        guard let currentTab = self.currentTabItem, currentTab != button else {
            return
        }
        self.currentTabIndex = button.tag
        let direction: UIPageViewController.NavigationDirection = button.tag > currentTab.tag ? .forward : .reverse
        self.pageViewController.setViewControllers(
            [self.contentViewControllers[self.currentTabIndex]], direction: direction, animated: true, completion: nil)
    }
}

extension FullBoardTabPageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let current = pageViewController.viewControllers?.first, current != previousViewControllers.first else {
            return
        }
        self.currentTabIndex = self.contentViewControllers.firstIndex(of: current)!
    }
}

extension FullBoardTabPageViewController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = self.contentViewControllers.firstIndex(of: viewController), index > 0 else {
            return nil
        }
        return self.contentViewControllers[index - 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = self.contentViewControllers.firstIndex(of: viewController), index < self.contentViewControllers.count - 1 else {
            return nil
        }
        return self.contentViewControllers[index + 1]
    }
}
