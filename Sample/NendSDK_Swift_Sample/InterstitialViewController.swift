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
        
        self.title = "InterstitialAd"

        NADInterstitial.sharedInstance().delegate = self
        NADInterstitial.sharedInstance().isOutputLog = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        NADInterstitial.sharedInstance().delegate = nil
    }
    
    // MARK: Actions
    
    @IBAction func buttonClicked(sender: UIButton) {
        var showResult: NADInterstitialShowResult
        showResult = NADInterstitial.sharedInstance().showAdFromViewController(self)
        
        switch(showResult){
        case .AD_SHOW_SUCCESS:
            print("AD_SHOW_SUCCESS")
            break
        case .AD_LOAD_INCOMPLETE:
            print("AD_LOAD_INCOMPLETE")
            break
        case .AD_REQUEST_INCOMPLETE:
            print("FAILED_AD_REQUEST")
            break
        case .AD_DOWNLOAD_INCOMPLETE:
            print("FAILED_AD_DOWNLOAD")
            break
        case .AD_FREQUENCY_NOT_REACHABLE:
            print("AD_FREQUENCY_NOT_REACHABLE")
            break
        case .AD_SHOW_ALREADY:
            print("AD_SHOW_ALREADY")
            break
        case .AD_CANNOT_DISPLAY:
            print("AD_CANNOT_DISPLAY")
            break
        }
    }

    // MARK: NADInterstitialDelegate
    
    func didFinishLoadInterstitialAdWithStatus(status: NADInterstitialStatusCode) {
        switch(status){
        case .SUCCESS:
            print("SUCCESS")
            break
        case .INVALID_RESPONSE_TYPE:
            print("INVALID_RESPONSE_TYPE")
            b.reak
        case .FAILED_AD_REQUEST:
            print("FAILED_AD_REQUEST")
            break
        case .FAILED_AD_DOWNLOAD:
            print("FAILED_AD_DOWNLOAD")
            break
        }
    }
    
    func didClickWithType(type: NADInterstitialClickType) {
        switch(type){
        case .DOWNLOAD:
            print("DOWNLOAD")
            break
        case .CLOSE:
            print("CLOSE")
            break
        case .INFORMATION:
            print("INFORMATION")
            break
        }
    }
}
