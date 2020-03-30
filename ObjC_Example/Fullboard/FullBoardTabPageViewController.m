//
//  FullBoardTabPageViewController.m
//  ObjC_Example
//
//  Copyright © 2017年 FAN Communications. All rights reserved.
//

#import "FullBoardTabPageViewController.h"

#import "TableViewController.h"
#import <NendAd/NADFullBoardLoader.h>

@interface FullBoardTabPageViewController () <UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property (nonatomic, weak) IBOutlet UIView *indicator;
@property (nonatomic, weak) IBOutlet UIView *tabContainer;
@property (nonatomic) IBOutlet NSLayoutConstraint *indicatorLeadingConstraint;

@property (nonatomic) NADFullBoardLoader *loader;
@property (nonatomic) NSArray<UIViewController *> *contentViewControllers;

@property (nonatomic, readonly) UIPageViewController *pageViewController;
@property (nonatomic, readonly) UIButton *currentTab;
@property (nonatomic) NSUInteger currentTabIndex;

- (IBAction)onTapTabItem:(UIButton *)sender;

@end

@implementation FullBoardTabPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    self.title = @"Tab";
    
    self.indicator.hidden = YES;
    self.tabContainer.hidden = YES;
    
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    
    __weak typeof(self) weakSelf = self;
    self.loader = [[NADFullBoardLoader alloc] initWithSpotId:@"485504" apiKey:@"30fda4b3386e793a14b27bedb4dcd29f03d638e5"];
    [self.loader loadAdWithCompletionHandler:^(NADFullBoard *ad, NADFullBoardLoaderError error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        if (weakSelf && ad) {
            weakSelf.indicator.hidden = NO;
            weakSelf.tabContainer.hidden = NO;
            ((UIButton *)weakSelf.tabContainer.subviews.firstObject).selected = YES;
            
            weakSelf.contentViewControllers = @[[TableViewController new], [TableViewController new], [ad fullBoardAdViewController]];
            [weakSelf.pageViewController setViewControllers:@[weakSelf.contentViewControllers.firstObject]
                                                  direction:UIPageViewControllerNavigationDirectionForward
                                                   animated:NO
                                                 completion:nil];
        }
    }];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    UIView *currentTab = self.currentTab;
    if (currentTab) {
        [coordinator animateAlongsideTransition:nil completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            self.indicatorLeadingConstraint.constant = CGRectGetMinX(currentTab.frame);
            [self.view layoutIfNeeded];
        }];
    }
}

- (UIPageViewController *)pageViewController
{
    return self.childViewControllers.firstObject;
}

- (UIButton *)currentTab
{
    __block UIButton *currentTab = nil;
    [self.tabContainer.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (((UIButton *)obj).selected) {
            currentTab = obj;
            *stop = YES;
        }
    }];
    return currentTab;
}

- (void)setCurrentTabIndex:(NSUInteger)currentTabIndex
{
    if (_currentTabIndex == currentTabIndex) {
        return;
    }
    
    UIButton *currentTab = [self.tabContainer viewWithTag:_currentTabIndex];
    UIButton *nextTab = [self.tabContainer viewWithTag:currentTabIndex];
    
    _currentTabIndex = currentTabIndex;
    
    currentTab.selected = NO;
    nextTab.selected = YES;
    
    [self.view layoutIfNeeded];
    self.indicatorLeadingConstraint.constant = CGRectGetMinX(nextTab.frame);
    [UIView animateWithDuration:0.3f animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)onTapTabItem:(UIButton *)sender
{
    UIButton *currentTab = self.currentTab;
    if (currentTab == sender) {
        return;
    }
    self.currentTabIndex = sender.tag;
    UIPageViewControllerNavigationDirection direction = sender.tag > currentTab.tag ? UIPageViewControllerNavigationDirectionForward : UIPageViewControllerNavigationDirectionReverse;
    [self.pageViewController setViewControllers:@[self.contentViewControllers[self.currentTabIndex]]
                                      direction:direction
                                       animated:YES
                                     completion:nil];
}

#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self.contentViewControllers indexOfObject:viewController];
    if (index == NSNotFound || index == 0) {
        return nil;
    }
    return self.contentViewControllers[--index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self.contentViewControllers indexOfObject:viewController];
    if (index == NSNotFound || index == self.contentViewControllers.count - 1) {
        return nil;
    }
    return self.contentViewControllers[++index];
}

#pragma mark - UIPageViewControllerDelegate

- (void)pageViewController:(UIPageViewController *)pageViewController
        didFinishAnimating:(BOOL)finished
   previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers
       transitionCompleted:(BOOL)completed
{
    UIViewController *current = pageViewController.viewControllers.firstObject;
    UIViewController *previous = previousViewControllers.firstObject;
    if (current != previous) {
        self.currentTabIndex = [self.contentViewControllers indexOfObject:current];
    }
}

@end
