//
//  SelectSizeTableViewController.m
//  NendSDK_Sample
//
//  Created by ADN on 2015/05/27.
//  Copyright (c) 2015年 F@N Communications. All rights reserved.
//

#import "SelectSizeTableViewController.h"

#import "AdViewController.h"
#import "AdAdjustViewController.h"

static NSString *const CellIdentifier = @"Cell";

@interface SelectSizeTableViewController ()

@property (nonatomic) NSArray<NSDictionary *> *items;

@end

@implementation SelectSizeTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSString *path = [[NSBundle mainBundle] pathForResource:@"banner" ofType:@"plist"];
    self.items = [NSArray arrayWithContentsOfFile:path];

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
}

- (NSString *)segueIdentifierForIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier;
    if (self.isAdjustAdSize) {
        identifier = @"PushAdjust";
    } else if (self.isIB) {
        identifier = self.items[indexPath.row][@"segue"];
    } else {
        identifier = @"PushDefault";
    }
    return identifier;
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
    NSString *size = self.items[indexPath.row][@"size"];
    cell.textLabel.text = size;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:[self segueIdentifierForIndexPath:indexPath] sender:self.items[indexPath.row]];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *viewController = segue.destinationViewController;
    NSDictionary *item = sender;
    if ([viewController isKindOfClass:[AdViewController class]]) {
        ((AdViewController *)viewController).apiKey = item[@"api_key"];
        ((AdViewController *)viewController).spotId = item[@"spot_id"];
    } else if ([viewController isKindOfClass:[AdAdjustViewController class]]) {
        ((AdAdjustViewController *)viewController).apiKey = item[@"api_key"];
        ((AdAdjustViewController *)viewController).spotId = item[@"spot_id"];
    }
    viewController.view.backgroundColor = [UIColor whiteColor];
    viewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
}

@end
