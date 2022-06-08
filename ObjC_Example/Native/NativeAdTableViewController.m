//
//  NativeAdTableViewController.m
//  ObjC_Example
//
//  Copyright (c) 2015年 FAN Communications. All rights reserved.
//

#import "NativeAdTableViewController.h"

#import "NativeAdViewController.h"

@interface NativeAdTableViewController ()

@property (nonatomic) NSArray<NSDictionary<NSString *, NSString *> *> *items;

@end

@implementation NativeAdTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    NSString *path = [[NSBundle mainBundle] pathForResource:@"native" ofType:@"plist"];
    self.items = [NSArray arrayWithContentsOfFile:path];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = (NSIndexPath *)sender;
    UIViewController *destinationViewController = segue.destinationViewController;
    destinationViewController.title = self.items[indexPath.row][@"title"];
    if ([segue.destinationViewController isKindOfClass:[NativeAdViewController class]]) {
        NativeAdViewController *vc = (NativeAdViewController *)destinationViewController;
        NSDictionary *item = self.items[indexPath.row];
        vc.spotId = item[@"spot"];
        vc.apiKey = item[@"api"];
        vc.nib = item[@"nib"];
    }
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    // Configure the cell...
    if (@available(iOS 14.0, *)) {
        UIListContentConfiguration *content = [cell defaultContentConfiguration];
        [content setText:self.items[indexPath.row][@"title"]];
        [cell setContentConfiguration:content];
    } else {
        cell.textLabel.text = self.items[indexPath.row][@"title"];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *segueIdentifier = self.items[indexPath.row][@"segue"];
    [self performSegueWithIdentifier:segueIdentifier sender:indexPath];
}

@end
