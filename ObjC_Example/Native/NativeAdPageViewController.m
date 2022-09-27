//
//  NativeAdPageViewController.m
//  ObjC_Example
//
//  Copyright (c) 2015年 FAN Communications. All rights reserved.
//

#import "NativeAdPageViewController.h"

#import <NendAd/NADNativeClient.h>
#import "NativeAdPageContentViewController.h"

static const NSInteger kNativeAdCount = 5;

@interface NativeAdPageViewController () <UIPageViewControllerDelegate, UIPageViewControllerDataSource, NADNativeDelegate>

@property (nonatomic) NADNativeClient *client;
@property (nonatomic) NSMutableArray<NativeAdPageContentViewController *> *contentViewControllers;
@property (nonatomic) UIPageViewController *pageViewController;

@end

@implementation NativeAdPageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                              navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                            options:nil];
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    self.pageViewController.view.frame = self.view.frame;
    [self.view addSubview:self.pageViewController.view];

    self.client = [[NADNativeClient alloc] initWithSpotID:485500 apiKey:@"10d9088b5bd36cf43b295b0774e5dcf7d20a4071"];
    self.contentViewControllers = [NSMutableArray array];

    // 5ページ分の広告を先にまとめて取得
    __weak typeof(self) weakSelf = self;
    dispatch_group_t group = dispatch_group_create();
    dispatch_apply(kNativeAdCount, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t i) {
        dispatch_group_enter(group);
        [self.client loadWithCompletionBlock:^(NADNative *ad, NSError *error) {
            if (ad) {
                ad.delegate = weakSelf;
                NativeAdPageContentViewController *vc = [weakSelf.storyboard instantiateViewControllerWithIdentifier:@"NativeAdPageContentViewController"];
                vc.view.frame = weakSelf.view.frame;
                vc.ad = ad;
                vc.position = weakSelf.contentViewControllers.count + 1;
                [weakSelf.contentViewControllers addObject:vc];
            } else {
                NSLog(@"%@", error);
            }
            dispatch_group_leave(group);
        }];
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        if (0 < self.contentViewControllers.count) {
            [self.pageViewController setViewControllers:@[ self.contentViewControllers[0] ] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:NULL];
        }
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self.contentViewControllers indexOfObject:(NativeAdPageContentViewController *)viewController];
    if (0 == index || NSNotFound == index) {
        return nil;
    }
    index--;
    return self.contentViewControllers[index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self.contentViewControllers indexOfObject:(NativeAdPageContentViewController *)viewController];
    if (index == NSNotFound || ++index == self.contentViewControllers.count) {
        return nil;
    }
    return self.contentViewControllers[index];
}

#pragma mark - NADNativeDelegate

- (void)nadNativeDidClickAd:(NADNative *)ad
{
    NSLog(@"nadNativeDidClickAd: %@", ad);
}

@end
