//
//  NativeAdCarouselViewController.m
//  NendSDK_Sample
//
//  Created by 于超 on 2016/03/10.
//  Copyright © 2016年 F@N Communications. All rights reserved.
//

#import "NativeAdCarouselViewController.h"
#import "NativeAdCarouselCell.h"

static const int adRow = 3;

#define screenWidth            [UIScreen mainScreen].bounds.size.width
#define screenHeight           [UIScreen mainScreen].bounds.size.height

@interface NativeAdCarouselViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) IBOutlet UITableView *table;
@property (nonatomic) NSMutableArray<NSString *> *items;

@end

@implementation NativeAdCarouselViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.items = [NSMutableArray array];
    for (int i = 0; i < 100; i++) {
        [self.items addObject:[NSString stringWithFormat:@"item%d", i + 1]];
    }
    
    self.table.delegate = self;
    self.table.dataSource = self;

}

- (void)didReceiveMemoryWarning {
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
    if (indexPath.row == adRow) {
        float height = 325;
        
        UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
        switch (orientation) {
            case UIInterfaceOrientationPortrait:
            case UIDeviceOrientationPortraitUpsideDown:
                break;
            case UIDeviceOrientationLandscapeRight:
            case UIDeviceOrientationLandscapeLeft:
                height = 200;
                break;
            case UIDeviceOrientationUnknown:
                break;
        }
        
        return height;
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
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        return cell;
    } else {
        static NSString *CellIdentifier = @"cell";
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = self.items[indexPath.row];
        
        return cell;
    }
}

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //
}

@end
