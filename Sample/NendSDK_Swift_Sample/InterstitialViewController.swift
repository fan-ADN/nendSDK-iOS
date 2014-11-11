//
//  InterstitialViewController.swift
//  NendSwiftSample
//
//  Created by ADN on 2014/09/10.
//  Copyright (c) 2014年 F@N Communications. All rights reserved.
//

import UIKit

class InterstitialViewController: UIViewController, NADInterstitialDelegate {

    @IBOutlet weak var showButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        showButton.addTarget(self, action: "buttonClicked:", forControlEvents: .TouchUpInside)

        NADInterstitial.sharedInstance().delegate = self
        NADInterstitial.sharedInstance().isOutputLog = true
        
        // 向き固定の場合の処理をここに書く
//        var orientationArray =
//        [
//            UIInterfaceOrientationIsLandscape(UIInterfaceOrientation.LandscapeLeft),
//            UIInterfaceOrientationIsLandscape(UIInterfaceOrientation.LandscapeRight)
//        ]
//        NADInterstitial.sharedInstance().supportedOrientations = orientationArray

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit{
        
        NADInterstitial.sharedInstance().delegate = nil
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: Actions
    
    func buttonClicked(sender: UIButton) {
        
        var showResult: NADInterstitialShowResult
        showResult = NADInterstitial.sharedInstance().showAd()
        
        switch(showResult.value){
        case AD_SHOW_SUCCESS.value:
            println("AD_SHOW_SUCCESS")
            break
        case AD_LOAD_INCOMPLETE.value:
            println("INVALID_RESPONSE_TYPE")
            break
        case AD_REQUEST_INCOMPLETE.value:
            println("FAILED_AD_REQUEST")
            break
        case AD_DOWNLOAD_INCOMPLETE.value:
            println("FAILED_AD_DOWNLOAD")
            break
        case AD_FREQUENCY_NOT_REACHABLE.value:
            println("AD_FREQUENCY_NOT_REACHABLE")
            break
        case AD_SHOW_ALREADY.value:
            println("AD_SHOW_ALREADY")
            break
        default:
            break
        }
        
    }


    // MARK: NADInterstitialDelegate
    
    func didFinishLoadInterstitialAdWithStatus(status: NADInterstitialStatusCode) {
        
        switch(status.value){
        case SUCCESS.value:
            println("SUCCESS")
            break
        case INVALID_RESPONSE_TYPE.value:
            println("INVALID_RESPONSE_TYPE")
            break
        case FAILED_AD_REQUEST.value:
            println("FAILED_AD_REQUEST")
            break
        case FAILED_AD_DOWNLOAD.value:
            println("FAILED_AD_DOWNLOAD")
            break
        default:
            break
        }
    }
    
    func didClickWithType(type: NADInterstitialClickType) {
        
        switch(type.value){
        case DOWNLOAD.value:
            println("DOWNLOAD")
            break
        case CLOSE.value:
            println("CLOSE")
            break
        default:
            break
        }

    }
}
