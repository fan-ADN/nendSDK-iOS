//
//  FeedView.swift
//  NendSDK_Sample
//
//  Copyright © 2015年 F@N Communications. All rights reserved.
//

import UIKit

class FeedView: UIView {
    
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var category: UILabel!
    @IBOutlet private weak var indicator: UIActivityIndicatorView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(FeedView.tapped(_:)))
        self.addGestureRecognizer(recognizer)
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
                    indicator.hidden = false;
                } else {
                    indicator.stopAnimating()
                    indicator.hidden = true
                }
            }
        }
    }
    
    var link: String?
    
    func tapped(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: self.link!)!)
    }
}
