//
//  NativeAdNoNibTelopTextView.m
//  ObjC_Example
//
//  Copyright © 2016年 FAN Communications. All rights reserved.
//

#import <NendAd/NADNativeViewRendering.h>
#import "NativeAdNoNibTelopTextView.h"

#define timerInterval 0.02f
#define distance 1.f

static float NATIVE_TELOP_PR_LABEL_WIDTH = 20;

@interface NativeAdNoNibTelopTextView () <NADNativeViewRendering>

@property (nonatomic) UIImageView *nativeAdImageView;
@property (nonatomic) UILabel *nativeAdPrTextLabel;
@property (nonatomic) UILabel *nativeAdShortTextLabel;
@property (nonatomic) UIScrollView *scrollView;

@property (nonatomic) float width;
@property (nonatomic) float point;
@property (nonatomic) NSTimer *timer;

@end

@implementation NativeAdNoNibTelopTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self) {
        self.clipsToBounds = YES;

        // adImageView
        _nativeAdImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                                                  0,
                                                                                  frame.size.height,
                                                                                  frame.size.height)];
        // prTextLabel
        _nativeAdPrTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.height,
                                                                                0,
                                                                                NATIVE_TELOP_PR_LABEL_WIDTH,
                                                                                frame.size.height)];
        _nativeAdPrTextLabel.adjustsFontSizeToFitWidth = YES;
        _nativeAdPrTextLabel.minimumScaleFactor = 0.5f;
        _nativeAdPrTextLabel.numberOfLines = 0;
        _nativeAdPrTextLabel.textAlignment = NSTextAlignmentCenter;
        _nativeAdPrTextLabel.backgroundColor = [UIColor lightGrayColor];
        _nativeAdPrTextLabel.textColor = [UIColor whiteColor];

        // shortTextLabel Scroll view
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(_nativeAdPrTextLabel.frame.origin.x + _nativeAdPrTextLabel.frame.size.width,
                                                                     0,
                                                                     frame.size.width - (_nativeAdPrTextLabel.frame.origin.x + _nativeAdPrTextLabel.frame.size.width),
                                                                     frame.size.height)];
        _scrollView.backgroundColor = [UIColor blackColor];

        // shortTextLabel
        _nativeAdShortTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                                   0,
                                                                                   1,
                                                                                   _scrollView.frame.size.height)];
        _nativeAdShortTextLabel.numberOfLines = 1;
        _nativeAdShortTextLabel.textColor = [UIColor whiteColor];
        _nativeAdShortTextLabel.backgroundColor = [UIColor clearColor];

        [_scrollView addSubview:_nativeAdShortTextLabel];

        [self addSubview:_nativeAdImageView];
        [self addSubview:_scrollView];
        [self addSubview:_nativeAdPrTextLabel];
    }

    return self;
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

- (void)startTelop
{
    _width = [_nativeAdShortTextLabel.text sizeWithAttributes:@{NSFontAttributeName : _nativeAdShortTextLabel.font}].width;
    _nativeAdShortTextLabel.frame = CGRectMake(_nativeAdShortTextLabel.frame.origin.x, _nativeAdShortTextLabel.frame.origin.y, _width, _nativeAdShortTextLabel.frame.size.height);

    _point = -_scrollView.frame.size.width;
    [self changeFrame];

    [self stopTimer];
    _timer = [NSTimer scheduledTimerWithTimeInterval:timerInterval
                                              target:self
                                            selector:@selector(animation)
                                            userInfo:nil
                                             repeats:YES];
}

- (void)animation
{
    if (_point >= _width) {
        _point = -_scrollView.frame.size.width;
    } else {
        _point += distance;
    }

    [self changeFrame];
}

- (void)changeFrame
{
    [_scrollView setContentOffset:CGPointMake(_point, 0)];
}

- (void)stopTimer
{
    if ([_timer isValid]) {
        [_timer invalidate];
    }
}

@end
