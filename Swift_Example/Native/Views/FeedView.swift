//
//  FeedView.swift
//  ObjC_Example
//
//  Copyright © 2015年 FAN Communications. All rights reserved.
//

import UIKit

class FeedView: UIView {
    
    @IBOutlet fileprivate weak var title: UILabel!
    @IBOutlet fileprivate weak var category: UILabel!
    @IBOutlet fileprivate weak var indicator: UIActivityIndicatorView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(FeedView.tapped(_:)))
        self.addGestureRecognizer(recognizer)
        
        if #available(iOS 13, *) {
            self.backgroundColor = UIColor(named: "NativeAdBackgroundColor")
            self.title.textColor = UIColor(named: "TextColor")
            self.category.textColor = UIColor(named: "TextColor")
        }
    }
    
    var titleText: String? {
        didSet {
            self.title.text = self.titleText
        }
    }
    
    var categoryText: String? {
        didSet {
            self.category.text = self.categoryText
        }
    }
    
    var adLoading: Bool = false {
        didSet {
            if let indicator = self.indicator {
                if self.adLoading {
                    self.title.text = "";
                    self.category.text = "";
                    indicator.startAnimating();
                    indicator.isHidden = false;
                } else {
                    indicator.stopAnimating()
                    indicator.isHidden = true
                }
            }
        }
    }
    
    var link: String?
    
    @objc func tapped(_ sender: AnyObject) {
        UIApplication.shared.openURL(URL(string: self.link!)!)
    }
}
