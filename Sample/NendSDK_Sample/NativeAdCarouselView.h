//
//  NativeAdCarouselView.h
//  NendSDK_Sample
//
//  Created by 于超 on 2016/03/17.
//  Copyright © 2016年 F@N Communications. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NADNativeViewRendering.h"

@interface NativeAdCarouselView : UIView<NADNativeViewRendering>
@property (nonatomic, weak) IBOutlet NADNativeImageView *nativeAdLogoImageView;
@property (nonatomic, weak) IBOutlet NADNativeLabel *nativeAdPromotionNameLabel;
@property (nonatomic, weak) IBOutlet NADNativeLabel *nativeAdPrTextLabel;
@property (nonatomic, weak) IBOutlet NADNativeLabel *nativeAdLongTextLabel;
@property (nonatomic, weak) IBOutlet NADNativeImageView *nativeAdImageView;
@property (nonatomic, weak) IBOutlet NADNativeLabel *nativeAdShortTextLabel;
@property (nonatomic, weak) IBOutlet NADNativeLabel *nativeAdPromotionUrlLabel;
@property (nonatomic, weak) IBOutlet NADNativeLabel *nativeAdActionButtonTextLabel;

@property (nonatomic) int index;

- (instancetype)initWithFrame:(CGRect)frame;

@end
