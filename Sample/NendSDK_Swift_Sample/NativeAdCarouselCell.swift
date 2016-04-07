//
//  NativeAdCarouselCell.swift
//  NendSDK_Sample
//
//  Copyright © 2016年 F@N Communications. All rights reserved.
//

import UIKit

let adCount: Int = 5
let timerInterval: NSTimeInterval = 3.0

class NativeAdCarouselCell: UITableViewCell, UIScrollViewDelegate, NADNativeDelegate {
    
    internal var direction: Int = 0
    
    private var client: NADNativeClient!
    private var adViewsP = [NativeAdCarouselView]()
    private var adViewsL = [NativeAdCarouselView]()
    private var ads = [NADNative]()
    private var scrollView: UIScrollView!
    private var pointP: CGFloat!
    private var pageP: CGFloat!
    private var pointL: CGFloat!
    private var pageL: CGFloat!
    
    private var timerP: NSTimer = NSTimer()
    private var timerL: NSTimer = NSTimer()
    
    private var landscapeWidth: CGFloat!
    private var cellWidth: CGFloat!
    
    deinit {
        print("NativeAdCarouselCell: deinit")
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.scrollView = UIScrollView()
        self.scrollView.delegate = self
        self.scrollView.backgroundColor = UIColor.clearColor()
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.directionalLockEnabled = true
        self.scrollView.pagingEnabled = false
        self.scrollView.bounces = false
        self.scrollView.decelerationRate = 0.3
        self.addSubview(self.scrollView)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(NativeAdCarouselCell.layoutUpdate(_:)), name: "layoutUpdate", object: nil)
        
        // 自動スクロール
        self.pointP = 0
        self.pageP = 1
        self.pointL = 0
        self.pageL = 1
    }
    
    func initAd() {
        self.client = NADNativeClient(spotId: "485504", apiKey: "30fda4b3386e793a14b27bedb4dcd29f03d638e5", advertisingExplicitly: .Promotion)
        self.client.delegate = self
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        let group = dispatch_group_create()
        dispatch_apply(adCount, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { (i) -> Void in
            dispatch_group_enter(group)
            self.client.loadWithCompletionBlock({ (ad, _) -> Void in
                if ad != nil {
                    let nibP = UINib(nibName: "NativeAdCarouselPortraitView", bundle: nil)
                    let nibL = UINib(nibName: "NativeAdCarouselLandscapeView", bundle: nil)
                    let viewP: NativeAdCarouselView = nibP.instantiateWithOwner(self, options: nil)[0] as! NativeAdCarouselView
                    let viewL: NativeAdCarouselView = nibL.instantiateWithOwner(self, options: nil)[0] as! NativeAdCarouselView
                    
                    self.ads.append(ad)
                    self.adViewsP.append(viewP)
                    self.adViewsL.append(viewL)
                }
                dispatch_group_leave(group)
            })
        }
        dispatch_group_notify(group, dispatch_get_main_queue()) { () -> Void in
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            self.setAd()
        }
    }
    
    func setAd() {
        if self.direction == 1 {
            for i in 0 ..< self.adViewsP.count {
                let viewP: NativeAdCarouselView = (self.adViewsP)[i]
                viewP.frame = CGRectMake(CGFloat(i) * adPortraitWidth, 0, adPortraitWidth, adPortraitHeight)
                
                dispatch_async(dispatch_get_main_queue(), {
                    let ad: NADNative = self.ads[i]
                    ad.intoView(viewP)
                })
            }
        } else if self.direction == 2 {
            for i in 0 ..< self.adViewsL.count {
                let viewL: NativeAdCarouselView = (self.adViewsL)[i]
                viewL.frame = CGRectMake(CGFloat(i) * adPortraitWidth, 0, adPortraitWidth, adPortraitHeight)
                
                dispatch_async(dispatch_get_main_queue(), {
                    let ad: NADNative = self.ads[i]
                    ad.intoView(viewL)
                })
            }
        }
        
        // スクロールビューに広告ビューを格納
        self.layoutUpdate()
    }
    
    func layoutUpdate(notification: NSNotification) {
        self.direction = notification.object as! Int
        UIScreen.mainScreen().bounds.size.width
        
        for subview in self.scrollView.subviews {
            subview.removeFromSuperview()
        }
        
        dispatch_async(dispatch_get_main_queue(), {
            self.setAd()
        })
    }
    
    func layoutUpdate() {
        self.cellWidth = UIScreen.mainScreen().bounds.size.width
        var width: CGFloat
        var height: CGFloat
        
        if self.direction == 1 {
            self.landscapeWidth = adPortraitWidth
            width = self.landscapeWidth
            height = adPortraitHeight
            
            for i in 0 ..< self.adViewsP.count {
                let adViewP: NativeAdCarouselView = (self.adViewsP)[i] as NativeAdCarouselView
                adViewP.index = i
                adViewP.frameUpdate(self.direction)
                self.scrollView.addSubview(adViewP)
            }
            self.scrollView.setContentOffset(CGPointMake(self.pointP, 0), animated:true)
        } else {
            if (self.cellWidth < adLandscapeWidth) {
                self.landscapeWidth = self.cellWidth - 20
            } else {
                self.landscapeWidth = adLandscapeWidth
            }
            width = self.landscapeWidth
            height = adLandscapeHeight
            
            for i in 0 ..< self.adViewsL.count {
                let adViewL: NativeAdCarouselView = (self.adViewsL)[i] as NativeAdCarouselView
                adViewL.index = i
                adViewL.frameUpdate(self.direction)
                self.scrollView.addSubview(adViewL)
            }
            self.scrollView.setContentOffset(CGPointMake(self.pointL, 0), animated:true)
        }
        
        self.scrollView.frame = CGRectMake(0, 0, self.cellWidth, height)
        self.scrollView.contentSize = CGSizeMake(width * CGFloat(adCount), 0)
        
        self.pageP = 1
        self.pageL = 1
        self.pointP = 0
        self.pointL = 0
        self.scrollView.setContentOffset(CGPointMake(0, 0), animated:false)
        // 自動スクロールタイマー設置
        if adCount > 1 {
            self.setTimer()
        }
    }
    
    // MARK: - UIScrollViewDelegate
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.animation()
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        self.animation()
    }
    
    func animation() {
        var distance: CGFloat = self.scrollView.contentOffset.x
        var adWidth: CGFloat
        if (self.direction == 1) {
            adWidth = adPortraitWidth
            
            for i in 1 ..< adCount + 1 {
                if distance + self.cellWidth / 2 < adWidth * CGFloat(i) {
                    if (i == 1) {
                        distance = 0
                    } else if (i == adCount) {
                        distance = adWidth * CGFloat(i) - self.cellWidth
                    } else {
                        distance = adWidth * CGFloat(i) - adWidth / 2 - self.cellWidth / 2
                    }
                    self.pageP = CGFloat(i)
                    break
                }
            }
            
            self.pointP = distance
        } else {
            adWidth = self.landscapeWidth
            
            for i in 1 ..< adCount + 1 {
                if distance + self.cellWidth / 2 < adWidth * CGFloat(i) {
                    if (i == 1) {
                        distance = 0
                    } else if (i == adCount) {
                        distance = adWidth * CGFloat(i) - self.cellWidth
                    } else {
                        distance = adWidth * CGFloat(i) - adWidth / 2 - self.cellWidth / 2
                    }
                    self.pageL = CGFloat(i)
                    break
                }
            }
            
            self.pointL = distance
        }
        
        self.scrollView.setContentOffset(CGPointMake(distance, 0), animated:true)
    }
    
    // 自動スクロール
    func setTimer() {
        if self.timerP.valid == true {
            self.timerP.invalidate()
        }
        if self.timerL.valid == true {
            self.timerL.invalidate()
        }
        if self.direction == 1 {
            self.timerP = NSTimer.scheduledTimerWithTimeInterval(timerInterval, target: self, selector:#selector(NativeAdCarouselCell.move), userInfo: nil, repeats: true)
        } else if self.direction == 2 {
            self.timerL = NSTimer.scheduledTimerWithTimeInterval(timerInterval, target: self, selector:#selector(NativeAdCarouselCell.move), userInfo: nil, repeats: true)
        }
    }
    
    func move() {
        if self.direction == 1 {
            if (self.pageP == CGFloat(adCount - 1)){
                self.pointP = adPortraitWidth * CGFloat(adCount) - cellWidth
                self.pageP = self.pageP + 1
                self.scrollView.setContentOffset(CGPointMake(self.pointP, 0), animated:true)
            } else if (self.pageP == 1) {
                self.pointP = self.pointP + adPortraitWidth * 1.5 - cellWidth / 2
                self.pageP = self.pageP + 1
                self.scrollView.setContentOffset(CGPointMake(self.pointP, 0), animated:true)
            } else if (self.pageP == CGFloat(adCount)){
                self.pointP = 0
                self.pageP = 1
                self.scrollView.setContentOffset(CGPointMake(0, 0), animated:false)
            } else {
                self.pointP = self.pointP + adPortraitWidth
                self.pageP = self.pageP + 1
                self.scrollView.setContentOffset(CGPointMake(self.pointP, 0), animated:true)
            }
            
        } else if self.direction == 2 {
            if (self.pageL == CGFloat(adCount - 1)){
                self.pointL = self.landscapeWidth * CGFloat(adCount) - cellWidth
                self.pageL = self.pageL + 1
                self.scrollView.setContentOffset(CGPointMake(self.pointL, 0), animated:true)
            } else if (self.pageL == 1) {
                self.pointL = self.pointL + self.landscapeWidth * 1.5 - cellWidth / 2
                self.pageL = self.pageL + 1
                self.scrollView.setContentOffset(CGPointMake(self.pointL, 0), animated:true)
            } else if (self.pageL == CGFloat(adCount)){
                self.pointL = 0
                self.pageL = 1
                self.scrollView.setContentOffset(CGPointMake(0, 0), animated:false)
            } else {
                self.pointL = self.pointL + self.landscapeWidth
                self.pageL = self.pageL + 1
                self.scrollView.setContentOffset(CGPointMake(self.pointL, 0), animated:true)
            }
        }
    }
    
    // MARK: - NADNativeDelegate
    func nadNativeDidClickAd(ad: NADNative!) {
        print(#function)
    }
    
    func nadNativeDidDisplayAd(ad: NADNative!, success: Bool) {
        print(#function)
    }
}
