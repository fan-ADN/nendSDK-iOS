//
//  NativeAdNoHelperInFeedViewController.m
//  ObjC_Example
//
//  Copyright © 2016年 FAN Communications. All rights reserved.
//

#import "NativeAdNoHelperInFeedViewController.h"

#import <NendAd/NADNativeClient.h>
#import "NativeAdCellView.h"

static NSString *const reuseIdentifier = @"Cell";
static NSString *const reuseAdIdentifier = @"AdCell";

@interface NativeAdNoHelperInFeedViewController ()

@property (nonatomic) NADNativeClient *client;
@property (nonatomic) NSMutableArray<NSNumber *> *adRows;
@property (nonatomic) NSMutableDictionary<NSNumber *, NADNative *> *adCache;

@end

@implementation NativeAdNoHelperInFeedViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Do any additional setup after loading the view.

    self.client = [[NADNativeClient alloc] initWithSpotId:@"485500"
                                                   apiKey:@"10d9088b5bd36cf43b295b0774e5dcf7d20a4071"];

    // Max 5
    self.adRows = [NSMutableArray arrayWithArray:@[@4, @8, @16, @32, @64]];
    self.adCache = [NSMutableDictionary new];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)isAdRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.adRows containsObject:@(indexPath.row)];
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
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 96.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self isAdRowAtIndexPath:indexPath]) {
        NativeAdCellView *cell = [tableView dequeueReusableCellWithIdentifier:reuseAdIdentifier forIndexPath:indexPath];
        NADNative *ad = self.adCache[@(indexPath.row)];
        if (ad) {
            [ad intoView:cell advertisingExplicitly:NADNativeAdvertisingExplicitlyAD];
        } else {
            __weak typeof(self) weakSelf = self;
            [self.client loadWithCompletionBlock:^(NADNative *ad, NSError *error) {
                if (ad) {
                    weakSelf.adCache[@(indexPath.row)] = ad;
                    [ad intoView:cell advertisingExplicitly:NADNativeAdvertisingExplicitlyAD];
                    
                    NSMutableParagraphStyle *paragrahStyle = [[NSMutableParagraphStyle alloc] init];
                    paragrahStyle.minimumLineHeight = 25.0;
                    paragrahStyle.maximumLineHeight = 25.0;
                    
                    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:ad.longText];
                    [attributedText addAttribute:NSParagraphStyleAttributeName
                                           value:paragrahStyle
                                           range:NSMakeRange(0, attributedText.length)];
                    
                    cell.longTextLabel.numberOfLines = 0;
                    cell.longTextLabel.attributedText = attributedText;
                } else {
                    // ここでは広告を取得できなかった場合は広告行を削除しています
                    [weakSelf.adRows removeObject:@(indexPath.row)];
                    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                }
            }];
        }
        return cell;
    } else {
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
        cell.textLabel.text = [NSString stringWithFormat:@"%ld スマホでプレイ中のゲームの攻略情報を自動配信と検索で一つに集約できるアプリ「ゲーマグ」提供開始", (long)indexPath.row];
        cell.detailTextLabel.text = @"http://gamag.jp/";
        return cell;
    }
}

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
