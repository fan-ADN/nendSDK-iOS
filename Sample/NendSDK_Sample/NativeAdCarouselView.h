//
//  NativeAdCarouselView.h
//  NendSDK_Sample
//
//  Copyright © 2016年 F@N Communications. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NADNativeViewRendering.h"

@interface NativeAdCarouselView : UIView

@property (nonatomic) int index;

- (void) frameUpdate:(NSNumber *) direction;

@end
