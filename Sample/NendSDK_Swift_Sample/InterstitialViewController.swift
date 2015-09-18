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
        let orientationArray =
        [
            UIInterfaceOrientation.Portrait.rawValue,
            UIInterfaceOrientation.PortraitUpsideDown.rawValue,
            UIInterfaceOrientation.LandscapeLeft.rawValue,
            UIInterfaceOrientation.LandscapeRight.rawValue
        ]
        NADInterstitial.sharedInstance().supportedOrientations = orientationArray

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
        
        switch(showResult.rawValue){
        case AD_SHOW_SUCCESS.rawValue:
            print("AD_SHOW_SUCCESS")
            break
        case AD_LOAD_INCOMPLETE.rawValue:
            print("INVALID_RESPONSE_TYPE")
            break
        case AD_REQUEST_INCOMPLETE.rawValue:
            print("FAILED_AD_REQUEST")
            break
        case AD_DOWNLOAD_INCOMPLETE.rawValue:
            print("FAILED_AD_DOWNLOAD")
            break
        case AD_FREQUENCY_NOT_REACHABLE.rawValue:
            print("AD_FREQUENCY_NOT_REACHABLE")
            break
        case AD_SHOW_ALREADY.rawValue:
            print("AD_SHOW_ALREADY")
            break
        default:
            break
        }
        
    }


    // MARK: NADInterstitialDelegate
    
    func didFinishLoadInterstitialAdWithStatus(status: NADInterstitialStatusCode) {
        
        switch(status.rawValue){
        case SUCCESS.rawValue:
            print("SUCCESS")
            break
        case INVALID_RESPONSE_TYPE.rawValue:
            print("INVALID_RESPONSE_TYPE")
            break
        case FAILED_AD_REQUEST.rawValue:
            print("FAILED_AD_REQUEST")
            break
        case FAILED_AD_DOWNLOAD.rawValue:
            print("FAILED_AD_DOWNLOAD")
            break
        default:
            break
        }
    }
    
    func didClickWithType(type: NADInterstitialClickType) {
        
        switch(type.rawValue){
        case DOWNLOAD.rawValue:
            print("DOWNLOAD")
            break
        case CLOSE.rawValue:
            print("CLOSE")
            break
        default:
            break
        }

    }
}
