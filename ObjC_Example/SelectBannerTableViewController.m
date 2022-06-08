//
//  SelectBannerTableViewController.m
//  ObjC_Example
//
//  Copyright (c) 2015年 FAN Communications. All rights reserved.
//

#import "SelectBannerTableViewController.h"

#import "SelectSizeTableViewController.h"

static NSString *const CellIdentifier = @"Cell";

@interface SelectBannerTableViewController ()

@property (nonatomic) NSArray<NSString *> *items;

@end

@implementation SelectBannerTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Banner";

    self.items = @[ @"default", @"adjust ad size", @"interface builder" ];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
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
        [cell setContentConfiguration:content];
    } else {
        cell.textLabel.text = self.items[indexPath.row];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"PushSelectSize" sender:indexPath];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    SelectSizeTableViewController *viewController = segue.destinationViewController;
    NSIndexPath *indexPath = sender;
    switch (indexPath.row) {
        case 0:
            viewController.isAdjustAdSize = NO;
            viewController.isIB = NO;
            break;
        case 1:
            viewController.isAdjustAdSize = YES;
            viewController.isIB = NO;
            break;
        case 2:
            viewController.isAdjustAdSize = NO;
            viewController.isIB = YES;
            break;
        default:
            break;
    }
    viewController.title = self.items[indexPath.row];
    viewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
}

@end
