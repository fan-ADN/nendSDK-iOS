//
//  FullBoardAdPageViewController.m
//  ObjC_Example
//
//  Copyright © 2017年 FAN Communications. All rights reserved.
//

#import "FullBoardAdPageViewController.h"

#import <NendAd/NADFullBoardLoader.h>
#import "FullBoardAdContentViewController.h"

@interface FullBoardAdPageViewController () <UIPageViewControllerDataSource, NADFullBoardViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (nonatomic, strong) NSMutableArray<UIViewController *> *contentViewControllers;
@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) NADFullBoardLoader *loader;

@end

@implementation FullBoardAdPageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                              navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                            options:nil];
    self.pageViewController.dataSource = self;
    self.pageViewController.view.frame = self.containerView.frame;
    [self.containerView addSubview:self.pageViewController.view];
    
    self.contentViewControllers = [NSMutableArray array];
    for (int i = 0; i < 5; i++) {
        FullBoardAdContentViewController *content = [self.storyboard instantiateViewControllerWithIdentifier:@"FullBoardPageContent"];
        content.number = [NSString stringWithFormat:@"%d",i + 1];
        [self.contentViewControllers addObject:content];
    }
    [self.pageViewController setViewControllers:@[self.contentViewControllers[0]]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:NULL];

    self.loader = [[NADFullBoardLoader alloc] initWithSpotID:485504 apiKey:@"30fda4b3386e793a14b27bedb4dcd29f03d638e5"];
    
    __weak typeof(self) weakSelf = self;
    for (NSInteger i = 0; i < 2; i++) {
        __block NSInteger insertIndex = 0 == i ? 2 : 4;
        [self.loader loadAdWithCompletionHandler:^(NADFullBoard *ad, NADFullBoardLoaderError error) {
            if (ad) {
                UIViewController<NADFullBoardView> *adViewController = [ad fullBoardAdViewController];
                adViewController.delegate = weakSelf;
                [weakSelf.contentViewControllers insertObject:adViewController atIndex:insertIndex];
            }
        }];
    }
    
}

#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self.contentViewControllers indexOfObject:viewController];
    if (0 == index || NSNotFound == index) {
        return nil;
    }
    index--;
    return self.contentViewControllers[index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self.contentViewControllers indexOfObject:viewController];
    if (index == NSNotFound || ++index == self.contentViewControllers.count) {
        return nil;
    }
    return self.contentViewControllers[index];
}

#pragma mark - NADFullBoardViewDelegate

- (void)NADFullBoardDidClickAd:(NADFullBoard *)ad
{
    NSLog(@"%s", __FUNCTION__);
}

@end
