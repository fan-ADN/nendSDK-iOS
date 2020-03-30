//
//  NativeAdCarouselView.h
//  ObjC_Example
//
//  Copyright © 2016年 FAN Communications. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <NendAd/NADNativeViewRendering.h>

@interface NativeAdCarouselView : UIView

@property (nonatomic) int index;

- (void) frameUpdate:(NSNumber *) direction;

@end
