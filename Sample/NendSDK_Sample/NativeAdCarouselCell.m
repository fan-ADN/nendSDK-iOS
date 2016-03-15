//
//  NativeAdCarouseCell.m
//  NendSDK_Sample
//
//  Created by 于超 on 2016/03/14.
//  Copyright © 2016年 F@N Communications. All rights reserved.
//

#import "NativeAdCarouselCell.h"
#import "NADNativeClient.h"

#define screenWidth            [UIScreen mainScreen].bounds.size.width
#define screenHeight           [UIScreen mainScreen].bounds.size.height

static const int adCount = 5; // 最大5枚

@interface NativeAdCarouselCell ()<NADNativeDelegate, UIScrollViewDelegate> {
    UIImageView *logo;
    UILabel *shortLabel;
    UILabel *prLabel;
    UILabel *longLabel;
}

@property (nonatomic) NADNativeClient *client;
@property (nonatomic) NSMutableArray *adContentViews;
@property (nonatomic) int index;
@property (nonatomic) UIScrollView *scrollView;

@end

@interface AdContentView : UIView <NADNativeViewRendering>

@property (nonatomic, strong) NADNativeLabel *nativeAdPrTextLabel;
@property (nonatomic, strong) NADNativeLabel *nativeAdShortTextLabel;
@property (nonatomic, strong) NADNativeLabel *nativeAdLongTextLabel;
@property (nonatomic, strong) NADNativeLabel *nativeAdPromotionNameLabel;
@property (nonatomic, strong) NADNativeLabel *nativeAdPromotionUrlLabel;
@property (nonatomic, strong) NADNativeLabel *nativeAdActionButtonTextLabel;
@property (nonatomic, strong) NADNativeImageView *nativeAdImageView;
@property (nonatomic, strong) NADNativeImageView *nativeAdLogoImageView;

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
    
    logo = [[UIImageView alloc] initWithFrame:CGRectMake(10.f, 10.f, 40.f, 40.f)];
    shortLabel = [[UILabel alloc] initWithFrame:CGRectMake(50.f, 10.f, screenWidth - 60, 30.f)];shortLabel.backgroundColor = [UIColor redColor];
    shortLabel.adjustsFontSizeToFitWidth = YES;
    shortLabel.minimumScaleFactor = 0.5f;
    prLabel = [[UILabel alloc] initWithFrame:CGRectMake(50.f, 40.f, screenWidth - 60, 30.f)];prLabel.backgroundColor = [UIColor yellowColor];
    prLabel.adjustsFontSizeToFitWidth = YES;
    longLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.f, 70.f, screenWidth - 20, 30.f)];longLabel.backgroundColor = [UIColor greenColor];
    longLabel.adjustsFontSizeToFitWidth = YES;
    longLabel.minimumScaleFactor = 0.5f;
    longLabel.numberOfLines = 2;
    
    [self.contentView addSubview:logo];
    [self.contentView addSubview:shortLabel];
    [self.contentView addSubview:prLabel];
    [self.contentView addSubview:longLabel];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, screenWidth, 260)];
    self.scrollView.delegate = self;
    self.scrollView.backgroundColor = [UIColor grayColor];
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
        self.adContentViews = [NSMutableArray array];
        
        // 5ページ分の広告を先にまとめて取得
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        __weak typeof(self) weakSelf = self;
        dispatch_group_t group = dispatch_group_create();
        dispatch_apply(adCount, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t i) {
            dispatch_group_enter(group);
            [self.client loadWithCompletionBlock:^(NADNative *ad, NSError *error) {
                if (ad) {
                    UIView<NADNativeViewRendering> *adView = [[AdContentView alloc] initWithFrame:CGRectMake(0.f, 0.f, 320, 260)];
                    
                    [ad intoView:adView];
                    [weakSelf.adContentViews addObject:adView];

                } else {
                    NSLog(@"%@", error);
                }
                dispatch_group_leave(group);
            }];
        });
        
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
            for (int i = 0; i < self.adContentViews.count; i ++) {
                AdContentView *adView = [self.adContentViews objectAtIndex:i];
                adView.frame = CGRectMake(320 * i, 0, 320, 260);
                adView.backgroundColor = [UIColor whiteColor];
                [self.scrollView addSubview:adView];
            }
            
            self.scrollView.contentSize =  CGSizeMake(320 * adCount, 0);
            [self updateHeader];
        });
        
    }
}

-(void) updateHeader {
    AdContentView *currentAdView = [self.adContentViews objectAtIndex:self.index];
    logo.image = currentAdView.nativeAdLogoImageView.image;
    shortLabel.text = currentAdView.nativeAdShortTextLabel.text;
    prLabel.text = currentAdView.nativeAdPrTextLabel.text;
    longLabel.text = currentAdView.nativeAdLongTextLabel.text;
}

#pragma mark UIScrollView

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    //
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self animation];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView{
    [self animation];
}

- (void) animation {
    int x = self.scrollView.contentOffset.x;
    
    if (x < 320 - screenWidth / 2) {
        x = 0;
        self.index = 0;
    } else if (x < 640 - screenWidth / 2) {
        x = 480 - screenWidth / 2;
        self.index = 1;
    } else if (x < 960 - screenWidth / 2) {
        x = 800 - screenWidth / 2;
        self.index = 2;
    } else if (x < 1280 - screenWidth / 2) {
        x = 1120 - screenWidth / 2;
        self.index = 3;
    } else {
        x = 1600 - screenWidth;
        self.index = 4;
    }
    
    [self updateHeader];
    [self.scrollView setContentOffset:CGPointMake(x, 0) animated:YES];
}

@end

@implementation AdContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _nativeAdLogoImageView = [[NADNativeImageView alloc] initWithFrame:CGRectMake(10.f, 10.f, 40.f, 40.f)];
        _nativeAdShortTextLabel = [[NADNativeLabel alloc] initWithFrame:CGRectMake(50.f, 10.f, 260.f, 30.f)];
        _nativeAdShortTextLabel.adjustsFontSizeToFitWidth = YES;
        _nativeAdShortTextLabel.minimumScaleFactor = 0.5f;
        _nativeAdPrTextLabel = [[NADNativeLabel alloc] initWithFrame:CGRectMake(50.f, 40.f, 260.f, 30.f)];
        _nativeAdLongTextLabel = [[NADNativeLabel alloc] initWithFrame:CGRectMake(10.f, 70.f, 300.f, 40.f)];
        _nativeAdLongTextLabel.adjustsFontSizeToFitWidth = YES;
        _nativeAdLongTextLabel.minimumScaleFactor = 0.5f;
        _nativeAdImageView = [[NADNativeImageView alloc] initWithFrame:CGRectMake(10.f, 10.f, 300.f, 180.f)];
        _nativeAdPromotionNameLabel = [[NADNativeLabel alloc] initWithFrame:CGRectMake(10.f, 190.f, 180.f, 30.f)];
        _nativeAdPromotionNameLabel.backgroundColor = [UIColor yellowColor];
        _nativeAdPromotionUrlLabel = [[NADNativeLabel alloc] initWithFrame:CGRectMake(10.f, 220.f, 180.f, 30.f)];
        _nativeAdPromotionUrlLabel.backgroundColor = [UIColor blueColor];
        _nativeAdActionButtonTextLabel = [[NADNativeLabel alloc] initWithFrame:CGRectMake(190.f, 200.f, 120.f, 30.f)];
        _nativeAdActionButtonTextLabel.backgroundColor = [UIColor orangeColor];
        
//        [self addSubview:_nativeAdLogoImageView];
//        [self addSubview:_nativeAdShortTextLabel];
        [self addSubview:_nativeAdPrTextLabel];
//        [self addSubview:_nativeAdLongTextLabel];
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
