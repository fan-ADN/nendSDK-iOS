//
//  NativeAdCarouseCell.m
//  NendSDK_Sample
//
//  Copyright © 2016年 F@N Communications. All rights reserved.
//

#import "NativeAdCarouselCell.h"
#import <NendAd/NADNativeClient.h>
#import "NativeAdCarouselView.h"

#define cellWidth       [UIScreen mainScreen].bounds.size.width
#define timerInterval     3.0f

dispatch_source_t CreateTimer(double interval, dispatch_queue_t queue, dispatch_block_t block)
{
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, interval * NSEC_PER_SEC), interval * NSEC_PER_SEC, (1ull * NSEC_PER_SEC) / 10);
    dispatch_source_set_event_handler(timer, block);
    dispatch_resume(timer);
    
    return timer;
}

static const int adCount = 5; // 最大5枚
static const float adPortraitWidth = 320.f; // 縦向き　広告横幅
static const float adPortraitHeight = 325.f; // 縦向き 広告高さ
static const float adLandscapeWidth = 580.f; // 横向き　広告横幅
static const float adLandscapeHeight = 200.f; // 横向き　広告高さ

@interface NativeAdCarouselCell ()<NADNativeDelegate, UIScrollViewDelegate>

@property (nonatomic) NADNativeClient *client;
@property (nonatomic) NSMutableArray *adViewsP;
@property (nonatomic) NSMutableArray *adViewsL;
@property (nonatomic) NSMutableArray *ads;
@property (nonatomic) UIScrollView *scrollView;

@property (nonatomic) float adLandscapeWidth; // 横向き　広告横幅
@property (nonatomic) dispatch_source_t timerP;
@property (nonatomic) float pointP;
@property (nonatomic) int pageP;
@property (nonatomic) dispatch_source_t timerL;
@property (nonatomic) float pointL;
@property (nonatomic) int pageL;

@end

@implementation NativeAdCarouselCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.delegate = self;
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.directionalLockEnabled = YES;
    self.scrollView.pagingEnabled = NO;
    self.scrollView.bounces = NO;
    self.scrollView.decelerationRate = 0.3;
    [self addSubview:self.scrollView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(layoutUpdate:) name:@"layoutUpdate" object:nil];
    
    // 自動スクロール
    self.pointP = 0;
    self.pageP = 1;
    self.pointL = 0;
    self.pageL = 1;
    
    return self;
}

- (void) initAd {
    if (self) {
        self.client = [[NADNativeClient alloc] initWithSpotId:@"485504" apiKey:@"30fda4b3386e793a14b27bedb4dcd29f03d638e5"];
        self.ads = [NSMutableArray array];
        self.adViewsP = [NSMutableArray array];
        self.adViewsL = [NSMutableArray array];
        
        // 5ページ分の広告を先にまとめて取得　縦画面
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        __weak typeof(self) weakSelf = self;
        dispatch_group_t group = dispatch_group_create();
        dispatch_apply(adCount, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t i) {
            dispatch_group_enter(group);
            [self.client loadWithCompletionBlock:^(NADNative *ad, NSError *error) {
                if (ad) {
                    ad.delegate = weakSelf;
                    UINib *nibP = [UINib nibWithNibName:@"NativeAdCarouselPortraitView" bundle:nil];
                    UIView<NADNativeViewRendering> *viewP = [nibP instantiateWithOwner:nil options:nil][0];
                    UINib *nibL = [UINib nibWithNibName:@"NativeAdCarouselLandscapeView" bundle:nil];
                    UIView<NADNativeViewRendering> *viewL = [nibL instantiateWithOwner:nil options:nil][0];
                    
                    [weakSelf.ads addObject:ad];
                    [weakSelf.adViewsP addObject:viewP];
                    [weakSelf.adViewsL addObject:viewL];
                } else {
                    NSLog(@"%@", error);
                }
                dispatch_group_leave(group);
            }];
        });
        
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            // 広告ビューを描画
            [self setAd];
        });
    }
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
    float adWidth;
    if ((self.direction).integerValue == 1) {
        adWidth = adPortraitWidth;
        
        for (int i = 1; i <= adCount; i ++) {
            if (distance + cellWidth / 2 < adWidth * i) {
                if (i == 1) {
                    distance = 0;
                } else if (i == adCount) {
                    distance = adWidth * i - cellWidth;
                } else {
                    distance = adWidth * i - adWidth / 2 - cellWidth / 2;
                }
                self.pageP = i;
                break;
            }
        }
        
        self.pointP = distance;
    } else {
        adWidth = self.adLandscapeWidth;
        
        for (int i = 1; i <= adCount; i ++) {
            if (distance + cellWidth / 2 < adWidth * i) {
                if (i == 1) {
                    distance = 0;
                } else if (i == adCount) {
                    distance = adWidth * i - cellWidth;
                } else {
                    distance = adWidth * i - adWidth / 2 - cellWidth / 2;
                }
                self.pageL = i;
                break;
            }
        }
        
        self.pointL = distance;
    }
    
    [self.scrollView setContentOffset:CGPointMake(distance, 0) animated:YES];
}

- (void) layoutUpdate:(NSNotification*) notification {
    self.direction = notification.object;
    
    for (UIView *subview in self.scrollView.subviews) {
        [subview removeFromSuperview];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setAd];
    });
}

-(void) setAd {
    if ((self.direction).intValue == 1) {
        for (int i = 0; i < self.adViewsP.count; i ++) {
            NativeAdCarouselView *viewP = (self.adViewsP)[i];
            viewP.frame = CGRectMake(i * adPortraitWidth, 0, adPortraitWidth, adPortraitHeight);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NADNative *ad = (self.ads)[i];
                [ad intoView:(UIView<NADNativeViewRendering> *)viewP advertisingExplicitly:NADNativeAdvertisingExplicitlyPR];
            });
        }
    } else if ((self.direction).intValue == 2) {
        for (int i = 0; i < self.adViewsL.count; i ++) {
            NativeAdCarouselView *viewL = (self.adViewsL)[i];
            viewL.frame = CGRectMake(i * adLandscapeWidth, 0, adLandscapeWidth, adLandscapeHeight);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NADNative *ad = (self.ads)[i];
                [ad intoView:(UIView<NADNativeViewRendering> *)viewL advertisingExplicitly:NADNativeAdvertisingExplicitlyPR];
            });
        }
    }
    
    // スクロールビューに広告ビューを格納
    [self layoutUpdate];
}

- (void) layoutUpdate {
    float width;
    float height;
    
    if ((self.direction).integerValue == 1) {
        self.adLandscapeWidth = adPortraitWidth;
        width = self.adLandscapeWidth;
        height = adPortraitHeight;
        
        for (int i = 0; i < self.adViewsP.count; i ++) {
            NativeAdCarouselView *adViewP = (self.adViewsP)[i];
            adViewP.index = i;
            [adViewP frameUpdate:self.direction];
            [self.scrollView addSubview:adViewP];
        }
        [self.scrollView setContentOffset:CGPointMake(self.pointP, 0) animated:YES];
    } else {
        if (cellWidth < adLandscapeWidth) {
            self.adLandscapeWidth = cellWidth - 20;
        } else {
            self.adLandscapeWidth = adLandscapeWidth;
        }
        width = self.adLandscapeWidth;
        height = adLandscapeHeight;
        
        for (int i = 0; i < self.adViewsL.count; i ++) {
            NativeAdCarouselView *adViewL = (self.adViewsL)[i];
            adViewL.index = i;
            [adViewL frameUpdate:self.direction];
            [self.scrollView addSubview:adViewL];
        }
        [self.scrollView setContentOffset:CGPointMake(self.pointL, 0) animated:YES];
    }
    
    self.scrollView.frame = CGRectMake(0.f, 0.f, cellWidth, height);
    self.scrollView.contentSize = CGSizeMake(width * adCount, 0);
    
    self.pageP = 1;
    self.pageL = 1;
    self.pointP = 0;
    self.pointL = 0;
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    // 自動スクロールタイマー設置
    if (adCount > 1) {
        [self setTimer];
    }
}

-(void) setTimer {
    [self cancelTimer];
    
    __weak typeof(self) weakSelf = self;
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    if ((self.direction).intValue == 1) {
        self.timerP = CreateTimer(timerInterval, queue, ^{
            [weakSelf move];
        });
    } else if ((self.direction).intValue == 2) {
        self.timerL = CreateTimer(timerInterval, queue, ^{
            [weakSelf move];
        });
    }
}

- (void)cancelTimer
{
    if (self.timerP) {
        dispatch_source_cancel(self.timerP);
        self.timerP = nil;
    }
    if (self.timerL) {
        dispatch_source_cancel(self.timerL);
        self.timerL = nil;
    }
}

- (void)move
{
    if ((self.direction).intValue == 1) {
        if (self.pageP == adCount - 1){
            self.pointP = adPortraitWidth * adCount - cellWidth;
            self.pageP ++;
            [self.scrollView setContentOffset:CGPointMake(self.pointP, 0) animated:YES];
        } else if (self.pageP == 1) {
            self.pointP += adPortraitWidth * 1.5 - cellWidth / 2;
            self.pageP ++;
            [self.scrollView setContentOffset:CGPointMake(self.pointP, 0) animated:YES];
        } else if (self.pageP == adCount){
            self.pointP = 0;
            self.pageP = 1;
            [self.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        } else {
            self.pointP += adPortraitWidth;
            self.pageP ++;
            [self.scrollView setContentOffset:CGPointMake(self.pointP, 0) animated:YES];
        }
        
    } else if ((self.direction).intValue == 2) {
        if (self.pageL == adCount - 1){
            self.pointL = self.adLandscapeWidth * adCount - cellWidth;
            self.pageL ++;
            [self.scrollView setContentOffset:CGPointMake(self.pointL, 0) animated:YES];
        } else if (self.pageL == 1) {
            self.pointL += self.adLandscapeWidth * 1.5 - cellWidth / 2;
            self.pageL ++;
            [self.scrollView setContentOffset:CGPointMake(self.pointL, 0) animated:YES];
        } else if (self.pageL == adCount){
            self.pointL = 0;
            self.pageL = 1;
            [self.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        } else {
            self.pointL += self.adLandscapeWidth;
            self.pageL ++;
            [self.scrollView setContentOffset:CGPointMake(self.pointL, 0) animated:YES];
        }
    }
    
}

#pragma mark - NADNativeDelegate

- (void)nadNativeDidClickAd:(NADNative *)ad
{
    NSLog(@"nadNativeDidClickAd: %@", ad);
}

@end
