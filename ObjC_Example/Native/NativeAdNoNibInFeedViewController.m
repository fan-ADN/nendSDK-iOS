//
//  NativeAdNoNibInFeedViewController.m
//  ObjC_Example
//
//  Copyright © 2016年 FAN Communications. All rights reserved.
//

#import "NativeAdNoNibInFeedViewController.h"

#import <NendAd/NADNativeTableViewHelper.h>

@interface NativeAdTableViewCell : UITableViewCell <NADNativeViewRendering>

@property (nonatomic, strong) UIImageView *nativeAdImageView;
@property (nonatomic, strong) UILabel *nativeAdPrTextLabel;
@property (nonatomic, strong) UILabel *nativeAdShortTextLabel;

@end

@implementation NativeAdTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _nativeAdImageView = [[UIImageView alloc] initWithFrame:CGRectMake(8.f, 8.f, 80.f, 80.f)];
        _nativeAdShortTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(96.f, 8.f, 218.f, 40.f)];
        _nativeAdShortTextLabel.adjustsFontSizeToFitWidth = YES;
        _nativeAdShortTextLabel.minimumScaleFactor = 0.5f;
        _nativeAdPrTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(96.f, 48.f, 218.f, 40.f)];
        [self.contentView addSubview:_nativeAdImageView];
        [self.contentView addSubview:_nativeAdShortTextLabel];
        [self.contentView addSubview:_nativeAdPrTextLabel];
    }
    return self;
}

#pragma mark - NADNativeViewRendering

- (UILabel *)prTextLabel
{
    return self.nativeAdPrTextLabel;
}

- (UILabel *)shortTextLabel
{
    return self.nativeAdShortTextLabel;
}

- (UIImageView *)adImageView
{
    return self.nativeAdImageView;
}

@end

@interface NativeAdNoNibInFeedViewController () <NADNativeTableViewHelperDelegate>

@property (nonatomic) NADNativeTableViewHelper *helper;
@property (nonatomic) NSMutableArray<NSString *> *items;

@end

@implementation NativeAdNoNibInFeedViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // Important
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.tableView registerClass:[NativeAdTableViewCell class] forCellReuseIdentifier:@"AdCell"];
    
    self.items = [NSMutableArray array];
    for (int i = 0; i < 50; i++) {
        [self.items addObject:[NSString stringWithFormat:@"item%d", i + 1]];
    }
    
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
    if (@available(iOS 14.0, *)) {
        UIListContentConfiguration *content = [cell defaultContentConfiguration];
        [content setText:self.items[indexPath.row]];
        [cell setContentConfiguration:content];
    } else {
        cell.textLabel.text = self.items[indexPath.row];
    }
    return cell;
}

#pragma mark - Table view delegate

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
