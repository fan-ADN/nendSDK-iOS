//
//  NativeVideoAdLandscapeView.swift
//  Swift_Example
//
//  Created by 馬場美沙都 on 2023/04/18.
//  Copyright © 2023 F@N Communications. All rights reserved.
//

import UIKit

class NativeVideoAdLandscapeView: NativeVideoAdBaseView {
    
    override init(frame: CGRect){
        super.init(frame: frame)
        loadXib()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        loadXib()
    }

    func loadXib(){
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "NativeVideoAdLandscapeView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        self.addSubview(view)
    }

}
