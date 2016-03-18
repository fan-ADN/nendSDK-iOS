//
//  NativeAdCarouseCell.m
//  NendSDK_Sample
//
//  Copyright © 2016年 F@N Communications. All rights reserved.
//

#import "NativeAdCarouselCell.h"
#import "NADNativeClient.h"
#import "NativeAdCarouselView.h"

#define cellWidth   [UIScreen mainScreen].bounds.size.width

static const int adCount = 5; // 最大5枚
static const float adPortraitHeight = 325.f; // 立て向き 広告高さ
static const float adLandscapeHeight = 200.f; // 横向き　広告高さ
static const float adPortraitWidth = 320.f; // 立て向き　広告横幅
static const float adLandscapeWidth = 580.f; // 横向き　広告横幅

@interface NativeAdCarouselCell ()<NADNativeDelegate, UIScrollViewDelegate>

@property (nonatomic) NADNativeClient *client;
@property (nonatomic) NSMutableArray *adViews;
@property (nonatomic) UIScrollView *scrollView;

// 広告の横幅
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
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f, 0.f, cellWidth, adPortraitHeight)];
    self.scrollView.delegate = self;
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.directionalLockEnabled = YES;
    self.scrollView.pagingEnabled = NO;
    self.scrollView.bounces = NO;
    self.scrollView.decelerationRate = 0.3;
    [self addSubview:self.scrollView];
    
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
                    UINib *nib = [UINib nibWithNibName:@"NativeAdCarouselView" bundle:nil];
                    UIView<NADNativeViewRendering> *adView = [[nib instantiateWithOwner:nil options:nil] objectAtIndex:0];
                    
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
                NativeAdCarouselView *adView = [self.adViews objectAtIndex:i];
                adView.frame = CGRectMake(i*320, 0, 320, 325);
                adView.index = i;
                [self.scrollView addSubview:adView];
            }
            
            // 画面レイアウト
            [self layoutSubviews];
        });
    }
}

-(void) layoutSubviews {
    [super layoutSubviews];
    
    float height = adPortraitHeight;
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    switch (orientation) {
        case UIInterfaceOrientationPortrait:
        case UIDeviceOrientationPortraitUpsideDown:
            self.adWidth = adPortraitWidth;
            break;
        case UIDeviceOrientationLandscapeRight:
        case UIDeviceOrientationLandscapeLeft:
            self.adWidth = adLandscapeWidth;
            height = adLandscapeHeight;
            break;
        case UIDeviceOrientationUnknown:
            break;
    }
    
    self.scrollView.frame = CGRectMake(0.f, 0.f, cellWidth, height);
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
    int distance = self.scrollView.contentOffset.x;
    
    if (distance + cellWidth/2 < self.adWidth) {
        distance = 0;
    } else if (distance + cellWidth/2 < self.adWidth * 2) {
        distance = self.adWidth * 1.5 - cellWidth / 2;
    } else if (distance + cellWidth/2 < self.adWidth * 3) {
        distance = self.adWidth * 2.5 - cellWidth / 2;
    } else if (distance + cellWidth / 2 < self.adWidth * 4) {
        distance = self.adWidth * 3.5 - cellWidth / 2;
    } else {
        distance = self.adWidth * 5 - cellWidth;
    }
    
    [self.scrollView setContentOffset:CGPointMake(distance, 0) animated:YES];
}

@end
