//
//  InterstitialViewController.swift
//  NendSwiftSample
//
//  Copyright (c) 2014年 F@N Communications. All rights reserved.
//

import UIKit
import NendAd

class InterstitialViewController: UIViewController, NADInterstitialDelegate {

    @IBOutlet weak var showButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "InterstitialAd"

        NADInterstitial.sharedInstance().delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        NADInterstitial.sharedInstance().delegate = nil
    }
    
    // MARK: Actions
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        var showResult: NADInterstitialShowResult
        showResult = NADInterstitial.sharedInstance().showAd(from: self)
        
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
    
    func didFinishLoadInterstitialAd(withStatus status: NADInterstitialStatusCode) {
        switch(status){
        case .SUCCESS:
            print("SUCCESS")
            break
        case .INVALID_RESPONSE_TYPE:
            print("INVALID_RESPONSE_TYPE")
            break
        case .FAILED_AD_REQUEST:
            print("FAILED_AD_REQUEST")
            break
        case .FAILED_AD_DOWNLOAD:
            print("FAILED_AD_DOWNLOAD")
            break
        }
    }
    
    func didClick(with type: NADInterstitialClickType) {
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
