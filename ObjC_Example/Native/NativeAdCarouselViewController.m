//
//  NativeAdCarouselViewController.m
//  ObjC_Example
//
//  Copyright © 2016年 FAN Communications. All rights reserved.
//

#import "NativeAdCarouselViewController.h"
#import "NativeAdCarouselCell.h"

static const int adRow = 3;
static const float cellPortrait = 325.f;
static const float cellLandscape = 200.f;

@interface NativeAdCarouselViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) NSMutableArray<NSString *> *items;
@property (nonatomic) NSNumber *direction; // 端末向き

@end

@implementation NativeAdCarouselViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.items = [NSMutableArray array];
    for (int i = 0; i < 100; i++) {
        [self.items addObject:[NSString stringWithFormat:@"item%d", i + 1]];
    }
    
    // 画面向きの判定
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    switch (orientation) {
        case UIInterfaceOrientationPortrait:
        case UIDeviceOrientationPortraitUpsideDown:
            self.direction = @1;
            break;
        case UIDeviceOrientationLandscapeRight:
        case UIDeviceOrientationLandscapeLeft:
            self.direction = @2;
            break;
        case UIDeviceOrientationUnknown:
            self.direction = @0;
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 画面向きの判定
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        
        if (size.width <= size.height) {
            self.direction = @1;
        } else {
            self.direction = @2;
        }
        
        [self.tableView reloadData];
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"layoutUpdate" object:self.direction];
    }];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == adRow) {
        if ((self.direction).integerValue == 1) {
            return cellPortrait;
        } else {
            return cellLandscape;
        }
    } else {
        return 44.f;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == adRow) {
        static NSString *AdCellIdentifier = @"adcell";
        NativeAdCarouselCell *cell= [tableView dequeueReusableCellWithIdentifier:AdCellIdentifier];
        if (cell == nil) {
            cell = [[NativeAdCarouselCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AdCellIdentifier];
            cell.direction = self.direction;
            cell.selectionStyle = UITableViewCellAccessoryDisclosureIndicator;
            [cell initAd];
        }
        
        return cell;
    } else {
        static NSString *CellIdentifier = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.textLabel.text = self.items[indexPath.row];
        
        return cell;
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //
}

@end
