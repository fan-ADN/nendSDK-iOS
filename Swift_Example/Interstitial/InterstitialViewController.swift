//
//  InterstitialViewController.swift
//  NendSwiftSample
//
//  Copyright (c) 2014年 FAN Communications. All rights reserved.
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
        case .AD_LOAD_INCOMPLETE:
            print("AD_LOAD_INCOMPLETE")
        case .AD_REQUEST_INCOMPLETE:
            print("FAILED_AD_REQUEST")
        case .AD_DOWNLOAD_INCOMPLETE:
            print("FAILED_AD_DOWNLOAD")
        case .AD_FREQUENCY_NOT_REACHABLE:
            print("AD_FREQUENCY_NOT_REACHABLE")
        case .AD_SHOW_ALREADY:
            print("AD_SHOW_ALREADY")
        case .AD_CANNOT_DISPLAY:
            print("AD_CANNOT_DISPLAY")
        @unknown default:
            break
        }
    }

    // MARK: NADInterstitialDelegate
    
    func didFinishLoadInterstitialAd(withStatus status: NADInterstitialStatusCode) {
        switch(status){
        case .SUCCESS:
            print("SUCCESS")
        case .INVALID_RESPONSE_TYPE:
            print("INVALID_RESPONSE_TYPE")
        case .FAILED_AD_REQUEST:
            print("FAILED_AD_REQUEST")
        case .FAILED_AD_DOWNLOAD:
            print("FAILED_AD_DOWNLOAD")
        @unknown default:
            break
        }
    }
    
    func didClick(with type: NADInterstitialClickType) {
        switch(type){
        case .DOWNLOAD:
            print("DOWNLOAD")
        case .CLOSE:
            print("CLOSE")
        case .INFORMATION:
            print("INFORMATION")
        @unknown default:
            break
        }
    }
}
