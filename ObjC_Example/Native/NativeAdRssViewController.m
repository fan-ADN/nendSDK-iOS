//
//  NativeAdRssViewController.m
//  ObjC_Example
//
//  Copyright © 2015年 FAN Communications. All rights reserved.
//

#import "NativeAdRssViewController.h"

#import <NendAd/NendAd.h>

#import "FeedView.h"

@interface Feed : NSObject

@property (nonatomic) BOOL isAd;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *link;

+ (instancetype)adSpace;

@end

@interface NativeAdRssViewController () <NADNativeTableViewHelperDelegate>

@property (nonatomic) NSArray<NSArray<Feed *> *> *items;
@property (nonatomic) NADNativeTableViewHelper *helper;

@end

@implementation NativeAdRssViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView.allowsSelection = NO;

    [self.tableView registerNib:[UINib nibWithNibName:@"FeedCell1" bundle:nil] forCellReuseIdentifier:@"FeedCell1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FeedCell2" bundle:nil] forCellReuseIdentifier:@"FeedCell2"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FeedCell3" bundle:nil] forCellReuseIdentifier:@"FeedCell3"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FeedCell4" bundle:nil] forCellReuseIdentifier:@"FeedCell4"];

    [self.tableView registerNib:[UINib nibWithNibName:@"FeedAdCell" bundle:nil] forCellReuseIdentifier:@"FeedAdCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FeedWithAdCell2" bundle:nil] forCellReuseIdentifier:@"FeedWithAdCell2"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FeedWithAdCell3" bundle:nil] forCellReuseIdentifier:@"FeedWithAdCell3"];

    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

    NSMutableArray<Feed *> *items = [NSMutableArray array];
    for (NSInteger i = 0; i < 50; i++) {
        Feed *feed = [Feed new];
        u_int32_t random = arc4random_uniform(2);
        if (0 == random) {
            feed.title = @"nendバナーカスタマイズ事例";
            feed.link = @"http://adn-mobasia.net/archives/1318";
        } else {
            feed.title = @"スマホでプレイ中のゲームの攻略情報を自動配信と検索で一つに集約できるアプリ「ゲーマグ」提供開始";
            feed.link = @"http://gamag.jp/";
        }
        feed.category = @"ニュースリリース";
        [items addObject:feed];
    }

    // 広告表示位置にダミーのFeedを追加
    Feed *adSpace = [Feed adSpace];
    [items insertObject:adSpace atIndex:5];
    [items insertObject:adSpace atIndex:9];
    self.items = [self dataSourceFromFeedArray:items];
    [self.tableView reloadData];
    
    NADNativeTableViewPlacement *placer = [NADNativeTableViewPlacement new];
    // 1行目は1つの広告を取得したFeedと一緒に表示
    [placer addFixedIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] fillRow:NO];
    // 3行目は1つの広告を取得したFeedと一緒に表示
    [placer addFixedIndexPath:[NSIndexPath indexPathForRow:3 inSection:0] fillRow:NO];
    // 6行目は広告行のみ
    [placer addFixedIndexPath:[NSIndexPath indexPathForRow:6 inSection:0]];

    self.helper = [NADNativeTableViewHelper helperWithTableView:self.tableView
                                                         spotId:@"485507"
                                                         apiKey:@"31e861edb574cfa0fb676ebdf0a0b9a0621e19fc"
                                          advertisingExplicitly:NADNativeAdvertisingExplicitlyPR
                                                    adPlacement:placer
                                                       delegate:self];
}

- (void)dealloc
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 引数のindexPathをそのまま使用
    NSArray<Feed *> *feeds = self.items[indexPath.row];
    NSString *identifier = [NSString stringWithFormat:@"FeedCell%lu", (long)feeds.count];
    // 広告行を含んだindexPathに変換しセルを取得
    NSIndexPath *reuseIndexPath = [self.helper actualIndexPathForOriginalIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:reuseIndexPath];
    
    // Configure the cell...
    [self bindFeeds:feeds intoCell:cell];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *feeds = self.items[indexPath.row];
    switch (feeds.count) {
        case 1:
            return 80.f;
        case 2:
            return 140.f;
        case 3:
            return 160.f;
        case 4:
            return 211.f;
    }
    return 0.f;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self tableView:tableView heightForRowAtIndexPath:indexPath];
}

#pragma mark - Private

- (NSArray<NSArray<Feed *> *> *)dataSourceFromFeedArray:(NSMutableArray<Feed *> *)feedArray
{
    NSArray *fix = @[ @4, @3, @1, @2 ];
    NSArray *loop = @[ @3, @1, @1, @3, @2 ];
    NSMutableArray<NSArray<Feed *> *> *feeds = [NSMutableArray array];
    NSInteger index = 0;
    NSArray *work = fix;
    for (;;) {
        if (index >= work.count) {
            index = 0;
        }
        NSInteger size = [work[index] integerValue];
        if (feedArray.count >= size) {
            NSMutableArray<Feed *> *array = [NSMutableArray array];
            for (NSInteger i = 0; i < size; i++) {
                Feed *feed = feedArray.firstObject;
                [array addObject:feed];
                [feedArray removeObjectAtIndex:0];
            }
            [feeds addObject:array];
        } else {
            break;
        }
        if (0 == feedArray.count) {
            break;
        }
        index++;
        if (work == fix && index == fix.count) {
            work = loop;
            index = 0;
        }
    }
    return feeds;
}

- (void)bindFeeds:(NSArray<Feed *> *)feeds intoCell:(UITableViewCell *)cell
{
    for (NSInteger i = 0; i < feeds.count; i++) {
        FeedView *feedView = (FeedView *)[cell viewWithTag:i + 1];
        Feed *feed = feeds[i];
        if (feed.isAd) {
            if (feedView) {
                feedView.adLoading = YES;
            }
            continue;
        }
        if (feedView) {
            feedView.adLoading = NO;
            feedView.titleText = feed.title;
            feedView.categoryText = feed.category;
            feedView.link = feed.link;
        } else {
            break;
        }
    }
}

#pragma mark - NADNativeTableViewHelperDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView adCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 広告行を除いたindexPathに変換し、該当行に表示させるFeedを取得する
    NSIndexPath *originalIndexPath = [self.helper originalIndexPathForActualIndexPath:indexPath];
    UITableViewCell *cell = nil;
    switch (indexPath.row) {
        case 1:
            cell = [tableView dequeueReusableCellWithIdentifier:@"FeedWithAdCell3" forIndexPath:indexPath];
            [self bindFeeds:self.items[originalIndexPath.row] intoCell:cell];
            break;
        case 3:
            cell = [tableView dequeueReusableCellWithIdentifier:@"FeedWithAdCell2" forIndexPath:indexPath];
            [self bindFeeds:self.items[originalIndexPath.row] intoCell:cell];
            break;
        case 6:
            cell = [tableView dequeueReusableCellWithIdentifier:@"FeedAdCell" forIndexPath:indexPath];
            break;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForAdRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 広告行の高さを返却
    switch (indexPath.row) {
        case 1:
            return 160.f;
        case 3:
            return 140.f;
        case 6:
            return 80.f;
    }
    return 0.f;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForAdRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self tableView:tableView heightForAdRowAtIndexPath:indexPath];
}

@end

#pragma mark -

@implementation Feed

+ (instancetype)adSpace
{
    Feed *feed = [Feed new];
    feed.isAd = YES;
    return feed;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _isAd = NO;
    }
    return self;
}

- (NSString *)description
{
    if (self.isAd) {
        return @"AD";
    } else {
        return self.title;
    }
}

@end
