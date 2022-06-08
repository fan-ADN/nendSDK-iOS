//
//  FullBoardAdMenuViewController.m
//  ObjC_Example
//
//  Copyright © 2017年 FAN Communications. All rights reserved.
//

#import "FullBoardAdMenuViewController.h"

static NSString *const CellIdentifier = @"Cell";

@interface FullBoardAdMenuViewController ()

@property (nonatomic) NSArray<NSString *> *items;
@property (nonatomic) NSArray<NSString *> *segues;
@property (nonatomic) NSArray<NSString *> *details;

@end

@implementation FullBoardAdMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"FullBoard";
    
    self.items = @[@"インタースティシャル形式", @"スワイプ形式", @"スクロールエンド形式", @"タブ形式"];
    self.segues = @[@"PushDefault", @"PushPage", @"PushScrollEnd", @"PushTab"];
    self.details = @[@"ポップアップで表示された広告は右上の×ボタンにより閉じることができます。",
                     @"マンガや小説などスワイプでページ送りをするアプリにてページとページの間に広告を差し込むことができます。※×ボタンは非表示にできます。",
                     @"ニュースや記事まとめ、縦スクロール式のマンガアプリなどで最下部までスクロールした後に画面下部から広告を呼び出します。右上の×ボタンにて閉じることができます。",
                     @"ニュースや記事まとめアプリでカテゴリタブの中に\"PR\"タブを作成し、PRタブがタップされた際に広告を表示します。"];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if (@available(iOS 14.0, *)) {
        UIListContentConfiguration *content = [cell defaultContentConfiguration];
        [content setText:self.items[indexPath.row]];
        [content setSecondaryText:self.details[indexPath.row]];
        [cell setContentConfiguration:content];
    } else {
        cell.textLabel.text = self.items[indexPath.row];
        cell.detailTextLabel.numberOfLines = 0;
        cell.detailTextLabel.text = self.details[indexPath.row];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:self.segues[indexPath.row] sender:nil];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *viewController = segue.destinationViewController;
    viewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
}

@end
