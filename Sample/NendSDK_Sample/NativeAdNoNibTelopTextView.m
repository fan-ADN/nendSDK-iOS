//
//  NativeAdNoNibTelopTextView.m
//  NendSDK_Sample
//
//  Copyright © 2016年 F@N Communications. All rights reserved.
//

#import "NADNativeViewRendering.h"
#import "NativeAdNoNibTelopTextView.h"

#define timerInterval 0.02f
#define distance 1.f

static float NATIVE_TELOP_PR_LABEL_WIDTH = 20;

@interface NativeAdNoNibTelopTextView () <NADNativeViewRendering>

@property (nonatomic) NADNativeImageView *nativeAdImageView;
@property (nonatomic) NADNativeLabel *nativeAdPrTextLabel;
@property (nonatomic) NADNativeLabel *nativeAdShortTextLabel;
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
        _nativeAdImageView = [[NADNativeImageView alloc] initWithFrame:CGRectMake(0,
                                                                                  0,
                                                                                  frame.size.height,
                                                                                  frame.size.height)];
        // prTextLabel
        _nativeAdPrTextLabel = [[NADNativeLabel alloc] initWithFrame:CGRectMake(frame.size.height,
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
        _nativeAdShortTextLabel = [[NADNativeLabel alloc] initWithFrame:CGRectMake(0,
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

        // Add Auto Layout Constraints
        _nativeAdShortTextLabel.translatesAutoresizingMaskIntoConstraints = NO;
        NSArray *constraintArray = @[
            [NSLayoutConstraint constraintWithItem:_nativeAdShortTextLabel
                                         attribute:NSLayoutAttributeTop
                                         relatedBy:NSLayoutRelationEqual
                                            toItem:_scrollView
                                         attribute:NSLayoutAttributeTop
                                        multiplier:1
                                          constant:0],
            [NSLayoutConstraint constraintWithItem:_nativeAdShortTextLabel
                                         attribute:NSLayoutAttributeLeading
                                         relatedBy:NSLayoutRelationEqual
                                            toItem:_scrollView
                                         attribute:NSLayoutAttributeLeading
                                        multiplier:1
                                          constant:0],
            [NSLayoutConstraint constraintWithItem:_nativeAdShortTextLabel
                                         attribute:NSLayoutAttributeWidth
                                         relatedBy:NSLayoutRelationGreaterThanOrEqual
                                            toItem:nil
                                         attribute:NSLayoutAttributeWidth
                                        multiplier:1
                                          constant:1],
            [NSLayoutConstraint constraintWithItem:_nativeAdShortTextLabel
                                         attribute:NSLayoutAttributeHeight
                                         relatedBy:NSLayoutRelationEqual
                                            toItem:_scrollView
                                         attribute:NSLayoutAttributeHeight
                                        multiplier:1
                                          constant:0],
        ];
        [_scrollView addConstraints:constraintArray];
    }

    return self;
}

#pragma mark - NADNativeViewRendering

- (NADNativeImageView *)adImageView
{
    return self.nativeAdImageView;
}

- (NADNativeLabel *)prTextLabel
{
    return self.nativeAdPrTextLabel;
}

- (NADNativeLabel *)shortTextLabel
{
    return self.nativeAdShortTextLabel;
}

- (void)startTelop
{
    _width = [_nativeAdShortTextLabel.text sizeWithAttributes:@{NSFontAttributeName : _nativeAdShortTextLabel.font}].width;

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
