//
//  Ad320_100ViewController.h
//  NendSDK_Sample
//
//  Created by ADN on 2013/07/19.
//  Copyright (c) 2013年 F@N Communications. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NADView.h"

@interface Ad320_100ViewController : UIViewController<NADViewDelegate>{
    NADView* nadView;
}

@property(nonatomic,retain)NADView* nadView;


@end
