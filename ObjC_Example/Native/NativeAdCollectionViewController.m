//
//  NativeAdCollectionViewController.m
//  ObjC_Example
//
//  Copyright (c) 2015年 FAN Communications. All rights reserved.
//

#import "NativeAdCollectionViewController.h"

#import <NendAd/NADNativeClient.h>
#import "NativeAdCollectionView.h"

static const NSUInteger kNativeAdInterval = 10;
static const NSUInteger kItemCount = 100;
static NSString *const reuseIdentifier = @"Cell";
static NSString *const reuseAdIdentifier = @"AdCell";

static BOOL isAdRow(NSInteger row)
{
    return kNativeAdInterval == row % (kNativeAdInterval + 1);
}

@interface NativeAdCollectionViewController ()

@property (nonatomic) NADNativeClient *client;
@property (nonatomic) NSArray<UIColor *> *colors;
@property (nonatomic) NSMutableArray<NADNative *> *ads;

@end

@implementation NativeAdCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;

    // Do any additional setup after loading the view.
    self.client = [[NADNativeClient alloc] initWithSpotID:485504 apiKey:@"30fda4b3386e793a14b27bedb4dcd29f03d638e5"];
    self.colors = @[ [UIColor redColor], [UIColor blueColor], [UIColor yellowColor], [UIColor greenColor], [UIColor purpleColor], [UIColor orangeColor] ];
    self.ads = [NSMutableArray array];
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
        
        __weak typeof(self) weakSelf = self;
        [self.client loadWithCompletionBlock:^(NADNative *ad, NSError *error) {
            if (ad) {
                [weakSelf.ads addObject:ad];
            } else {
                if (self.ads.count == 0) {
                    return;
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
