//
//  NativeAdTelopShortTextView.m
//  NendSDK_Sample
//
//  Copyright © 2016年 F@N Communications. All rights reserved.
//

#import "NativeAdTelopTextView.h"
#import "NADNativeViewRendering.h"
#define timerInterval     0.02f
#define distance          1.f

@interface NativeAdTelopTextView ()<NADNativeViewRendering>

@property (nonatomic, weak) IBOutlet UIImageView *nativeAdImageView;
@property (nonatomic, weak) IBOutlet UILabel *nativeAdPrTextLabel;
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet UILabel *nativeAdShortTextLabel;

@property (nonatomic) float width;
@property (nonatomic) float point;
@property (nonatomic) NSTimer *timer;

@end

@implementation NativeAdTelopTextView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _nativeAdPrTextLabel.adjustsFontSizeToFitWidth = YES;
    _nativeAdPrTextLabel.minimumScaleFactor = 0.5f;
    
    _scrollView.clipsToBounds = YES;
    _scrollView.scrollEnabled = NO;
    
    self.clipsToBounds = YES;
    self.layer.borderWidth = 1.f;
}

- (void) layoutSubviews {
    [super layoutSubviews];
}

#pragma mark - NADNativeViewRendering

- (UIImageView *)adImageView
{
    return self.nativeAdImageView;
}

- (UILabel *)prTextLabel
{
    return self.nativeAdPrTextLabel;
}

- (UILabel *)shortTextLabel
{
    return self.nativeAdShortTextLabel;
}

- (void)startTelop {
    
    _width = [_nativeAdShortTextLabel.text sizeWithAttributes:@{NSFontAttributeName:_nativeAdShortTextLabel.font}].width;
    
    _point = -_scrollView.frame.size.width;
    [self changeFrame];
    
    [self stopTimer];
    _timer = [NSTimer scheduledTimerWithTimeInterval:timerInterval
                                     target:self
                                   selector:@selector(animation)
                                   userInfo:nil
                                    repeats:YES];
}

- (void)animation {
    if (_point >= _width) {
        _point = -_scrollView.frame.size.width;
    } else {
        _point += distance;
    }
    
    [self changeFrame];
}

- (void)changeFrame {
    [_scrollView setContentOffset:CGPointMake(_point, 0)];
}

- (void)stopTimer {
    if ([_timer isValid]) {
        [_timer invalidate];
    }
}

@end
