//
//  NativeAdCollectionViewController.m
//  NendSDK_Sample
//
//  Copyright (c) 2015年 F@N Communications. All rights reserved.
//

#import "NativeAdCollectionViewController.h"

#import "NADNativeClient.h"
#import "NativeAdCollectionView.h"

static const NSUInteger kNativeAdInterval = 10;
static const NSUInteger kItemCount = 100;
static NSString *const reuseIdentifier = @"Cell";
static NSString *const reuseAdIdentifier = @"AdCell";

static BOOL isAdRow(NSInteger row)
{
    return 0 != row && 0 == row % kNativeAdInterval;
}

@interface NativeAdCollectionViewController ()

@property (nonatomic) NADNativeClient *client;
@property (nonatomic) NSArray<UIColor *> *colors;
@property (nonatomic) NSMutableArray<NADNative *> *ads;
@property (nonatomic) BOOL stopAdLoad;

@end

@implementation NativeAdCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;

    // Do any additional setup after loading the view.
    self.client = [[NADNativeClient alloc] initWithSpotId:@"485502" apiKey:@"a3972604a76864dd110d0b02204f4b72adb092ae"];
    self.colors = @[ [UIColor redColor], [UIColor blueColor], [UIColor yellowColor], [UIColor greenColor], [UIColor purpleColor], [UIColor orangeColor] ];
    self.ads = [NSMutableArray array];
    self.stopAdLoad = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NADNative * _Nonnull)adFromCacheAtIndexPath:(NSIndexPath * _Nonnull)indexPath
{
    NSInteger pos = (indexPath.row / kNativeAdInterval - 1) % self.ads.count;
    return self.ads[pos];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return kItemCount + kItemCount / kNativeAdInterval;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (isAdRow(indexPath.row)) {
        NativeAdCollectionView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseAdIdentifier forIndexPath:indexPath];
        if (!self.stopAdLoad) {
            __weak typeof(self) weakSelf = self;
            [self.client loadWithCompletionBlock:^(NADNative *ad, NSError *error) {
                if (ad) {
                    [weakSelf.ads addObject:ad];
                } else {
                    if (kNADNativeErrorCodeExcessiveAdCalls == error.code) {
                        // 広告の取得限界に達した場合は追加でロードを行わない
                        weakSelf.stopAdLoad = YES;
                    }
                    ad = [weakSelf adFromCacheAtIndexPath:indexPath];
                }
                [ad intoView:cell advertisingExplicitly:NADNativeAdvertisingExplicitlyAD];
                
                NSMutableParagraphStyle *paragrahStyle = [[NSMutableParagraphStyle alloc] init];
                paragrahStyle.minimumLineHeight = 15.0;
                paragrahStyle.maximumLineHeight = 15.0;
                
                NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:ad.shortText];
                [attributedText addAttribute:NSParagraphStyleAttributeName
                                       value:paragrahStyle
                                       range:NSMakeRange(0, attributedText.length)];
                
                cell.shortTextLabel.numberOfLines = 0;
                cell.shortTextLabel.attributedText = attributedText;
            }];
        } else {
            // 広告の取得限界に達している場合は取得済みの広告を表示させる
            [[self adFromCacheAtIndexPath:indexPath] intoView:cell advertisingExplicitly:NADNativeAdvertisingExplicitlyAD];
        }
        return cell;
    } else {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        cell.contentView.backgroundColor = self.colors[(indexPath.row - indexPath.row / kNativeAdInterval) % self.colors.count];
        return cell;
    }
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (!isAdRow(indexPath.row)) {
        NSLog(@"Click normal cell.");
    }
}

@end
