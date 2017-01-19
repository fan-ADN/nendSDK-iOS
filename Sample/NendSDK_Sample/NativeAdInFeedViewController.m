//
//  NativeAdInFeedViewController.m
//  NendSDK_Sample
//
//  Copyright (c) 2015年 F@N Communications. All rights reserved.
//

#import "NativeAdInFeedViewController.h"

#import <NendAd/NADNativeTableViewHelper.h>

@interface NativeAdInFeedViewController () <NADNativeTableViewHelperDelegate>

@property (nonatomic) NADNativeTableViewHelper *helper;
@property (nonatomic) NSMutableArray<NSString *> *items;

@end

@implementation NativeAdInFeedViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    self.items = [NSMutableArray array];
    for (int i = 0; i < 100; i++) {
        [self.items addObject:[NSString stringWithFormat:@"item%d", i + 1]];
    }
    
    [NADNativeLogger setLogLevel:NADNativeLogLevelWarn];
    
    NADNativeTableViewPlacement *placer = [NADNativeTableViewPlacement new];
    
    // 10行毎に広告を表示する場合
    [placer addRepeatInterval:10 inSection:0];

    // 行指定で表示する場合
//    [placer addFixedIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
//    [placer addFixedIndexPath:[NSIndexPath indexPathForRow:8 inSection:0]];
//    [placer addFixedIndexPath:[NSIndexPath indexPathForRow:16 inSection:0]];
    
    self.helper = [NADNativeTableViewHelper helperWithTableView:self.tableView
                                                         spotId:@"485500"
                                                         apiKey:@"10d9088b5bd36cf43b295b0774e5dcf7d20a4071"
                                          advertisingExplicitly:NADNativeAdvertisingExplicitlyPR
                                                    adPlacement:placer
                                                       delegate:self];    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return 44.f;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 広告行を含んだindexPathに変換しセルを取得
    NSIndexPath *reuseIndexPath = [self.helper actualIndexPathForOriginalIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:reuseIndexPath];
    // 引数のindexPathをそのまま使用
    cell.textLabel.text = self.items[indexPath.row];
    return cell;
}

#pragma mark - Table view delegate

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"SectionHeader";
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return @"SectionFooter";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 36.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 36.f;
}

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 広告行を含んだindexPathに変換し選択状態を解除
    NSIndexPath *actualIndexPath = [self.helper actualIndexPathForOriginalIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:actualIndexPath animated:YES];
}

#pragma mark - NADNativeTableViewHelperDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForAdRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 96.f;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForAdRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 96.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView adCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 広告行用のセルを取得
    return [tableView dequeueReusableCellWithIdentifier:@"AdCell" forIndexPath:indexPath];
}

@end
