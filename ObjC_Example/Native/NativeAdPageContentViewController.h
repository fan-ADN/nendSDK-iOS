//
//  NativeAdPageContentViewController.h
//  ObjC_Example
//
//  Copyright (c) 2015年 FAN Communications. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <NendAd/NADNative.h>

@interface NativeAdPageContentViewController : UIViewController

@property (nonatomic) NADNative *ad;
@property (nonatomic) NSUInteger position;

@end
