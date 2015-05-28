//
//  Ad320_050IBViewController.h
//  NendSDK_Sample
//
//  Created by ADN on 2015/05/27.
//  Copyright (c) 2015年 F@N Communications. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NADView.h"

@interface Ad320_050IBViewController : UIViewController<NADViewDelegate>{
    IBOutlet NADView* upNadView;        // 標準サイズのバナー
    IBOutlet NADView* bottomNadView;    // 広告サイズの自動調整を使用したバナー
}


@end
