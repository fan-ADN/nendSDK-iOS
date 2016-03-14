//
//  NativeAdCarouseCell.h
//  NendSDK_Sample
//
//  Copyright © 2016年 F@N Communications. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NativeAdCarouselCell : UITableViewCell

// 端末向き
@property (nonatomic) NSNumber *direction;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

- (void) initAd;

@end
