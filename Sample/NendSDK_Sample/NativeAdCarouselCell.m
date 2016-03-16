//
//  NativeAdCarouseCell.m
//  NendSDK_Sample
//
//  Created by 于超 on 2016/03/14.
//  Copyright © 2016年 F@N Communications. All rights reserved.
//

#import "NativeAdCarouselCell.h"
#import "NADNativeClient.h"

static const int adCount = 5; // 最大5枚

@interface AdView : UIView <NADNativeViewRendering>

@property (nonatomic, strong) NADNativeLabel *nativeAdPrTextLabel;
@property (nonatomic, strong) NADNativeLabel *nativeAdShortTextLabel;
@property (nonatomic, strong) NADNativeLabel *nativeAdLongTextLabel;
@property (nonatomic, strong) NADNativeLabel *nativeAdPromotionNameLabel;
@property (nonatomic, strong) NADNativeLabel *nativeAdPromotionUrlLabel;
@property (nonatomic, strong) NADNativeLabel *nativeAdActionButtonTextLabel;
@property (nonatomic, strong) NADNativeImageView *nativeAdImageView;
@property (nonatomic, strong) NADNativeImageView *nativeAdLogoImageView;

@property (nonatomic) int index;
- (instancetype)initWithFrame:(CGRect)frame;

@end

@interface NativeAdCarouselCell ()<NADNativeDelegate, UIScrollViewDelegate>

@property (nonatomic) NADNativeClient *client;
@property (nonatomic) NSMutableArray *adViews;
@property (nonatomic) NSMutableArray *adContentViews;
@property (nonatomic) UIScrollView *scrollView;

@property (nonatomic) float cellWidth;
@property (nonatomic) float adWidth;

@end

@implementation NativeAdCarouselCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f, 0.f, [UIScreen mainScreen].bounds.size.width, 325.f)];
    self.scrollView.delegate = self;
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.directionalLockEnabled = YES;
    self.scrollView.pagingEnabled = NO;
    self.scrollView.bounces = NO;
    self.scrollView.decelerationRate = 0.3;
    [self addSubview:self.scrollView];
    
    [self initAd];
    
    return self;
}

- (void) initAd {
    if (self) {
        self.client = [[NADNativeClient alloc] initWithSpotId:@"485504" apiKey:@"30fda4b3386e793a14b27bedb4dcd29f03d638e5" advertisingExplicitly:NADNativeAdvertisingExplicitlyPR];
        self.client.delegate = self;
        self.adViews = [NSMutableArray array];
        
        // 5ページ分の広告を先にまとめて取得
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        __weak typeof(self) weakSelf = self;
        dispatch_group_t group = dispatch_group_create();
        dispatch_apply(adCount, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t i) {
            dispatch_group_enter(group);
            [self.client loadWithCompletionBlock:^(NADNative *ad, NSError *error) {
                if (ad) {
                    UIView<NADNativeViewRendering> *adView = [[AdView alloc] initWithFrame:CGRectMake(0.f, 0.f, 320.f, 325.f)];
                    [ad intoView:adView];
                    [weakSelf.adViews addObject:adView];
                    
                } else {
                    NSLog(@"%@", error);
                }
                dispatch_group_leave(group);
            }];
        });
        
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
            for (int i = 0; i < self.adViews.count; i ++) {
                AdView *adView = [self.adViews objectAtIndex:i];
                adView.index = i;
                adView.backgroundColor = [UIColor whiteColor];
                [self.scrollView addSubview:adView];
            }
            
            [self layoutSubviews];
        });
    }
}

-(void) layoutSubviews {
    [super layoutSubviews];
    float height = 325;
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    switch (orientation) {
        case UIInterfaceOrientationPortrait:
        case UIDeviceOrientationPortraitUpsideDown:
            self.cellWidth = [UIScreen mainScreen].bounds.size.width;
            self.adWidth = 320;
            break;
        case UIDeviceOrientationLandscapeRight:
        case UIDeviceOrientationLandscapeLeft:
            self.cellWidth = [UIScreen mainScreen].bounds.size.width;
            self.adWidth = 580;
            height = 200;
            break;
        case UIDeviceOrientationUnknown:
            break;
    }
    
    self.scrollView.frame = CGRectMake(0.f, 0.f, self.cellWidth, height);
    self.scrollView.contentSize =  CGSizeMake(self.adWidth * adCount, 0);
}

#pragma mark UIScrollView

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self animation];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView{
    [self animation];
}

- (void) animation {
    int x = self.scrollView.contentOffset.x;
    
    if (x + self.cellWidth/2 < self.adWidth) {
        x = 0;
    } else if (x + self.cellWidth/2 < self.adWidth*2) {
        x = self.adWidth*1.5 - self.cellWidth/2;
    } else if (x  + self.cellWidth/2 < self.adWidth*3) {
        x = self.adWidth*2.5 - self.cellWidth/2;
    } else if (x  + self.cellWidth/2 < self.adWidth*4) {
        x = self.adWidth*3.5 - self.cellWidth/2;
    } else {
        x = self.adWidth*5 - self.cellWidth;
    }
    
    [self.scrollView setContentOffset:CGPointMake(x, 0) animated:YES];
}

@end

@implementation AdView

-(void) layoutSubviews {
    [super layoutSubviews];
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    switch (orientation) {
        case UIInterfaceOrientationPortrait:
        case UIDeviceOrientationPortraitUpsideDown:
            self.frame = CGRectMake(320 * self.index, 0, 320, 325);
            _nativeAdLogoImageView.frame = CGRectMake(10.f, 10.f, 40.f, 40.f);
            _nativeAdPromotionNameLabel.frame = CGRectMake(60.f, 10.f, 250.f, 20.f);
            _nativeAdPrTextLabel.frame = CGRectMake(60.f, 30.f, 40.f, 20.f);
            _nativeAdLongTextLabel.frame = CGRectMake(10.f, 55.f, 300.f, 30.f);
            _nativeAdImageView.frame = CGRectMake(10.f, 90.f, 300.f, 180.f);
            _nativeAdShortTextLabel.frame = CGRectMake(10.f, 275.f, 200.f, 20.f);
            _nativeAdPromotionUrlLabel.frame = CGRectMake(10.f, 295.f, 180.f, 20.f);
            _nativeAdActionButtonTextLabel.frame = CGRectMake(190.f, 295.f, 120.f, 20.f);
            break;
        case UIDeviceOrientationLandscapeRight:
        case UIDeviceOrientationLandscapeLeft:
            self.frame = CGRectMake(580 * self.index, 0, 580, 300);
            _nativeAdImageView.frame = CGRectMake(10.f, 10.f, 300.f, 180.f);
            _nativeAdPromotionNameLabel.frame = CGRectMake(320.f, 10.f, 180.f, 20.f);
            _nativeAdPrTextLabel.frame = CGRectMake(320.f, 40, 40.f, 20.f);
            _nativeAdLongTextLabel.frame = CGRectMake(320.f, 65.f, 250.f, 40.f);
            _nativeAdShortTextLabel.frame = CGRectMake(320.f, 110.f, 250.f, 20.f);
            _nativeAdPromotionUrlLabel.frame = CGRectMake(320.f, 140.f, 200.f, 20.f);
            _nativeAdActionButtonTextLabel.frame = CGRectMake(320.f, 170.f, 120.f, 20.f);
            _nativeAdLogoImageView.frame = CGRectMake(530.f, 150.f, 40.f, 40.f);
            break;
        case UIDeviceOrientationUnknown:
            break;
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _nativeAdLogoImageView = [[NADNativeImageView alloc] initWithFrame:CGRectMake(10.f, 10.f, 40.f, 40.f)];
        _nativeAdPromotionNameLabel = [[NADNativeLabel alloc] initWithFrame:CGRectMake(60.f, 10.f, 250.f, 20.f)];
        _nativeAdPromotionNameLabel.adjustsFontSizeToFitWidth = YES;
        _nativeAdPromotionNameLabel.font = [UIFont boldSystemFontOfSize:18];
        _nativeAdPromotionNameLabel.minimumScaleFactor = 0.5f;
        _nativeAdPrTextLabel = [[NADNativeLabel alloc] initWithFrame:CGRectMake(60.f, 30.f, 40.f, 20.f)];
        _nativeAdPrTextLabel.textAlignment = NSTextAlignmentCenter;
        _nativeAdPrTextLabel.backgroundColor = [UIColor grayColor];
        _nativeAdPrTextLabel.textColor = [UIColor whiteColor];
        _nativeAdPrTextLabel.adjustsFontSizeToFitWidth = YES;
        _nativeAdPrTextLabel.minimumScaleFactor = 0.5f;
        _nativeAdLongTextLabel = [[NADNativeLabel alloc] initWithFrame:CGRectMake(10.f, 55.f, 300.f, 30.f)];
        _nativeAdLongTextLabel.adjustsFontSizeToFitWidth = YES;
        _nativeAdLongTextLabel.minimumScaleFactor = 0.5f;
        _nativeAdImageView = [[NADNativeImageView alloc] initWithFrame:CGRectMake(10.f, 90.f, 300.f, 180.f)];
        _nativeAdShortTextLabel = [[NADNativeLabel alloc] initWithFrame:CGRectMake(10.f, 275.f, 200.f, 20.f)];
        _nativeAdShortTextLabel.adjustsFontSizeToFitWidth = YES;
        _nativeAdShortTextLabel.minimumScaleFactor = 0.5f;
        _nativeAdPromotionUrlLabel = [[NADNativeLabel alloc] initWithFrame:CGRectMake(10.f, 295.f, 180.f, 20.f)];
        _nativeAdPromotionUrlLabel.adjustsFontSizeToFitWidth = YES;
        _nativeAdPromotionUrlLabel.minimumScaleFactor = 0.5f;
        _nativeAdActionButtonTextLabel = [[NADNativeLabel alloc] initWithFrame:CGRectMake(190.f, 295.f, 120.f, 20.f)];
        _nativeAdActionButtonTextLabel.textColor = [UIColor blueColor];
        _nativeAdActionButtonTextLabel.layer.borderWidth = 1.f;
        _nativeAdActionButtonTextLabel.layer.borderColor = [[UIColor blueColor] CGColor];
        _nativeAdActionButtonTextLabel.textAlignment = NSTextAlignmentCenter;
        _nativeAdActionButtonTextLabel.adjustsFontSizeToFitWidth = YES;
        _nativeAdActionButtonTextLabel.minimumScaleFactor = 0.5f;
        
        [self addSubview:_nativeAdLogoImageView];
        [self addSubview:_nativeAdShortTextLabel];
        [self addSubview:_nativeAdPrTextLabel];
        [self addSubview:_nativeAdLongTextLabel];
        [self addSubview:_nativeAdImageView];
        [self addSubview:_nativeAdPromotionNameLabel];
        [self addSubview:_nativeAdPromotionUrlLabel];
        [self addSubview:_nativeAdActionButtonTextLabel];
        
        self.layer.borderWidth = 0.f;
    }
    return self;
}

#pragma mark - NADNativeViewRendering

- (NADNativeLabel *)prTextLabel
{
    return self.nativeAdPrTextLabel;
}

- (NADNativeLabel *)shortTextLabel
{
    return self.nativeAdShortTextLabel;
}

- (NADNativeLabel *)longTextLabel
{
    return self.nativeAdLongTextLabel;
}

- (NADNativeLabel *)promotionNameLabel
{
    return self.nativeAdPromotionNameLabel;
}

- (NADNativeLabel *)promotionUrlLabel
{
    return self.nativeAdPromotionUrlLabel;
}

- (NADNativeLabel *)actionButtonTextLabel
{
    return self.nativeAdActionButtonTextLabel;
}

- (NADNativeImageView *)adImageView
{
    return self.nativeAdImageView;
}

- (NADNativeImageView *)logoImageView
{
    return self.nativeAdLogoImageView;
}

@end
