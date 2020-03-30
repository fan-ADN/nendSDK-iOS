//
//  NativeAdCarouselCell.swift
//  ObjC_Example
//
//  Copyright © 2016年 FAN Communications. All rights reserved.
//

import UIKit
import NendAd

func CreateTimer(_ interval: Double, queue: DispatchQueue, block: @escaping ()->()) -> DispatchSource
{
    let timer = DispatchSource.makeTimerSource(queue: .main)
    timer.schedule(deadline: .now() + timerInterval, repeating: timerInterval)

    (timer as! DispatchSource).setEventHandler(handler: block);
    timer.resume()

    return timer as! DispatchSource;
}

let adCount: Int = 5
let timerInterval: TimeInterval = 3.0

class NativeAdCarouselCell: UITableViewCell, UIScrollViewDelegate, NADNativeDelegate {
    
    internal var direction: Int = 0
    
    fileprivate var client: NADNativeClient!
    fileprivate var adViewsP = [NativeAdCarouselView]()
    fileprivate var adViewsL = [NativeAdCarouselView]()
    fileprivate var ads = [NADNative]()
    fileprivate var scrollView: UIScrollView!
    fileprivate var pointP: CGFloat!
    fileprivate var pageP: CGFloat!
    fileprivate var pointL: CGFloat!
    fileprivate var pageL: CGFloat!
    
    fileprivate var timerP: DispatchSource!
    fileprivate var timerL: DispatchSource!
    
    fileprivate var landscapeWidth: CGFloat!
    fileprivate var cellWidth: CGFloat!
    
    deinit {
        print("NativeAdCarouselCell: deinit")
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.scrollView = UIScrollView()
        self.scrollView.delegate = self
        self.scrollView.backgroundColor = UIColor.clear
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.isDirectionalLockEnabled = true
        self.scrollView.isPagingEnabled = false
        self.scrollView.bounces = false
        self.scrollView.decelerationRate = UIScrollView.DecelerationRate(rawValue: 0.3)
        self.addSubview(self.scrollView)
        NotificationCenter.default.addObserver(self, selector:#selector(NativeAdCarouselCell.layoutUpdate(_:)), name: NSNotification.Name(rawValue: "layoutUpdate"), object: nil)
        
        // 自動スクロール
        self.pointP = 0
        self.pageP = 1
        self.pointL = 0
        self.pageL = 1
    }
    
    func initAd() {
        self.client = NADNativeClient(spotId: "485504", apiKey: "30fda4b3386e793a14b27bedb4dcd29f03d638e5")
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let group = DispatchGroup()
        DispatchQueue.concurrentPerform(iterations: adCount) { (i) -> Void in
            group.enter()
            self.client.load(completionBlock: { (ad, _) -> Void in
                if ad != nil {
                    let nibP = UINib(nibName: "NativeAdCarouselPortraitView", bundle: nil)
                    let nibL = UINib(nibName: "NativeAdCarouselLandscapeView", bundle: nil)
                    let viewP: NativeAdCarouselView = nibP.instantiate(withOwner: self, options: nil)[0] as! NativeAdCarouselView
                    let viewL: NativeAdCarouselView = nibL.instantiate(withOwner: self, options: nil)[0] as! NativeAdCarouselView
                    
                    self.ads.append(ad!)
                    self.adViewsP.append(viewP)
                    self.adViewsL.append(viewL)
                }
                group.leave()
            })
        }
        group.notify(queue: DispatchQueue.main) { () -> Void in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            self.setAd()
        }
    }
    
    func setAd() {
        if self.direction == 1 {
            for i in 0 ..< self.adViewsP.count {
                let viewP: NativeAdCarouselView = (self.adViewsP)[i]
                viewP.frame = CGRect(x: CGFloat(i) * adPortraitWidth, y: 0, width: adPortraitWidth, height: adPortraitHeight)
                
                DispatchQueue.main.async(execute: {
                    let ad: NADNative = self.ads[i]
                    ad.delegate = self;
                    ad.intoView(viewP, advertisingExplicitly: .promotion)
                })
            }
        } else if self.direction == 2 {
            for i in 0 ..< self.adViewsL.count {
                let viewL: NativeAdCarouselView = (self.adViewsL)[i]
                viewL.frame = CGRect(x: CGFloat(i) * adPortraitWidth, y: 0, width: adPortraitWidth, height: adPortraitHeight)
                
                DispatchQueue.main.async(execute: {
                    let ad: NADNative = self.ads[i]
                    ad.delegate = self;
                    ad.intoView(viewL, advertisingExplicitly: .promotion)
                })
            }
        }
        
        // スクロールビューに広告ビューを格納
        self.layoutUpdate()
    }
    
    @objc func layoutUpdate(_ notification: Notification) {
        self.direction = notification.object as! Int
        
        for subview in self.scrollView.subviews {
            subview.removeFromSuperview()
        }
        
        DispatchQueue.main.async(execute: {
            self.setAd()
        })
    }
    
    func layoutUpdate() {
        self.cellWidth = UIScreen.main.bounds.size.width
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
            self.scrollView.setContentOffset(CGPoint(x: self.pointP, y: 0), animated:true)
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
            self.scrollView.setContentOffset(CGPoint(x: self.pointL, y: 0), animated:true)
        }
        
        self.scrollView.frame = CGRect(x: 0, y: 0, width: self.cellWidth, height: height)
        self.scrollView.contentSize = CGSize(width: width * CGFloat(adCount), height: 0)
        
        self.pageP = 1
        self.pageL = 1
        self.pointP = 0
        self.pointL = 0
        self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated:false)
        // 自動スクロールタイマー設置
        if adCount > 1 {
            self.setTimer()
        }
    }
    
    // MARK: - UIScrollViewDelegate
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.cancelTimer()
        self.animation()
        
        if (self.pageP == CGFloat(adCount)){
            self.pointP = adPortraitWidth
            self.pageP = 2
            self.scrollView.setContentOffset(CGPoint(x: self.pointP, y: 0), animated:false)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.setTimer()
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
        
        self.scrollView.setContentOffset(CGPoint(x: distance, y: 0), animated:true)
    }
    
    // 自動スクロール
    func setTimer() {
        self.cancelTimer()
        
        weak var weakSelf = self
        let queue = DispatchQueue.main
        if self.direction == 1 {
            self.timerP = CreateTimer(timerInterval, queue: queue, block: {
                weakSelf!.move()
            })
        } else if self.direction == 2 {
            self.timerL = CreateTimer(timerInterval, queue: queue, block: {
                weakSelf!.move()
            })
        }
    }
    
    func cancelTimer() {
        if(self.timerP != nil) {
            self.timerP.cancel()
            self.timerP = nil
        }
        if(self.timerL != nil) {
            self.timerL.cancel()
            self.timerL = nil
        }
    }
    
    func move() {
        if self.direction == 1 {
            if (self.pageP == CGFloat(adCount - 1)){
                self.pointP = adPortraitWidth * CGFloat(adCount) - cellWidth
                self.pageP = self.pageP + 1
                self.scrollView.setContentOffset(CGPoint(x: self.pointP, y: 0), animated:true)
            } else if (self.pageP == 1) {
                self.pointP = self.pointP + adPortraitWidth * 1.5 - cellWidth / 2
                self.pageP = self.pageP + 1
                self.scrollView.setContentOffset(CGPoint(x: self.pointP, y: 0), animated:true)
            } else if (self.pageP == CGFloat(adCount)){
                self.pointP = adPortraitWidth
                self.pageP = 2
                self.scrollView.setContentOffset(CGPoint(x: self.pointP, y: 0), animated:false)
            } else {
                self.pointP = self.pointP + adPortraitWidth
                self.pageP = self.pageP + 1
                self.scrollView.setContentOffset(CGPoint(x: self.pointP, y: 0), animated:true)
            }
            
        } else if self.direction == 2 {
            if (self.pageL == CGFloat(adCount - 1)){
                self.pointL = self.landscapeWidth * CGFloat(adCount) - cellWidth
                self.pageL = self.pageL + 1
                self.scrollView.setContentOffset(CGPoint(x: self.pointL, y: 0), animated:true)
            } else if (self.pageL == 1) {
                self.pointL = self.pointL + self.landscapeWidth * 1.5 - cellWidth / 2
                self.pageL = self.pageL + 1
                self.scrollView.setContentOffset(CGPoint(x: self.pointL, y: 0), animated:true)
            } else if (self.pageL == CGFloat(adCount)){
                self.pointL = 0
                self.pageL = 1
                self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated:false)
            } else {
                self.pointL = self.pointL + self.landscapeWidth
                self.pageL = self.pageL + 1
                self.scrollView.setContentOffset(CGPoint(x: self.pointL, y: 0), animated:true)
            }
        }
    }
    
    // MARK: - NADNativeDelegate
    func nadNativeDidClickAd(_ ad: NADNative!) {
        print(#function)
    }
}
