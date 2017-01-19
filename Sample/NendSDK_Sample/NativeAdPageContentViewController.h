//
//  NativeAdPageContentViewController.h
//  NendSDK_Sample
//
//  Copyright (c) 2015年 F@N Communications. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <NendAd/NADNative.h>

@interface NativeAdPageContentViewController : UIViewController

@property (nonatomic) NADNative *ad;
@property (nonatomic) NSUInteger position;

@end
