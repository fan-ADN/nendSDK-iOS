//
//  NativeAdCarouseCell.h
//  ObjC_Example
//
//  Copyright © 2016年 FAN Communications. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NativeAdCarouselCell : UITableViewCell

// 端末向き
@property (nonatomic) NSNumber *direction;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

- (void) initAd;

@end
