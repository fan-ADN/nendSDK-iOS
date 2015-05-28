//
//  SelectBannerTableViewController.m
//  NendSDK_Sample
//
//  Created by ADN on 2015/05/27.
//  Copyright (c) 2015年 F@N Communications. All rights reserved.
//

#import "SelectBannerTableViewController.h"

#import "SelectSizeTableViewController.h"

@implementation SelectBannerTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0) {
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
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
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0) {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    }
    else{
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
    }
    
    // Configure the cell...
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    NSInteger row = indexPath.row;
    
    switch (row) {
        case 0:
            [cell.textLabel setText:@"default"];
            break;
            
        case 1:
            [cell.textLabel setText:@"adjust ad size"];
            break;
            
        case 2:
            [cell.textLabel setText:@"interface builder"];
            break;
        default:
            break;
    }
    
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    SelectSizeTableViewController *viewController = [[SelectSizeTableViewController alloc] init];
    switch (row) {
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
    
    viewController.view.backgroundColor = [UIColor whiteColor];
    viewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    [self.navigationController pushViewController:viewController animated:YES];
}


@end
