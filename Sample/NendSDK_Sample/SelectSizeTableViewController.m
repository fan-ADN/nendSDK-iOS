//
//  SelectSizeTableViewController.m
//  NendSDK_Sample
//
//  Created by ADN on 2015/05/27.
//  Copyright (c) 2015年 F@N Communications. All rights reserved.
//

#import "SelectSizeTableViewController.h"

#import "Ad320_050ViewController.h"
#import "Ad320_100ViewController.h"
#import "Ad300_100ViewController.h"
#import "Ad300_250ViewController.h"
#import "Ad728_090ViewController.h"
#import "Ad320_050IBViewController.h"
#import "Ad320_100IBViewController.h"
#import "Ad300_100IBViewController.h"
#import "Ad300_250IBViewController.h"
#import "Ad728_090IBViewController.h"
#import "Ad320_050AdjustViewController.h"
#import "Ad320_100AdjustViewController.h"
#import "Ad300_100AdjustViewController.h"
#import "Ad300_250AdjustViewController.h"
#import "Ad728_090AdjustViewController.h"

@implementation SelectSizeTableViewController

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
    return 5;
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
            [cell.textLabel setText:@"320×50"];
            break;
            
        case 1:
            [cell.textLabel setText:@"320×100"];
            break;
            
        case 2:
            [cell.textLabel setText:@"300×100"];
            break;
            
        case 3:
            [cell.textLabel setText:@"300×250"];
            break;
            
        case 4:
            [cell.textLabel setText:@"728×90"];
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
    UIViewController *viewController;
    if (self.isAdjustAdSize) {
        switch (row) {
            case 0:
                viewController = [[Ad320_050AdjustViewController alloc] init];
                break;
                
            case 1:
                viewController = [[Ad320_100AdjustViewController alloc] init];
                break;
                
            case 2:
                viewController = [[Ad300_100AdjustViewController alloc] init];
                break;
                
            case 3:
                viewController = [[Ad300_250AdjustViewController alloc] init];
                break;
                
            case 4:
                viewController = [[Ad728_090AdjustViewController alloc] init];
                break;
                
            default:
                break;
        }
    } else if (self.isIB){
        switch (row) {
            case 0:
                viewController = [[Ad320_050IBViewController alloc] init];
                break;
                
            case 1:
                viewController = [[Ad320_100IBViewController alloc] init];
                break;
                
            case 2:
                viewController = [[Ad300_100IBViewController alloc] init];
                break;
                
            case 3:
                viewController = [[Ad300_250IBViewController alloc] init];
                break;
                
            case 4:
                viewController = [[Ad728_090IBViewController alloc] init];
                break;
                
            default:
                break;
        }
    } else{
        switch (row) {
            case 0:
                viewController = [[Ad320_050ViewController alloc] init];
                break;
                
            case 1:
                viewController = [[Ad320_100ViewController alloc] init];
                break;
                
            case 2:
                viewController = [[Ad300_100ViewController alloc] init];
                break;
                
            case 3:
                viewController = [[Ad300_250ViewController alloc] init];
                break;
                
            case 4:
                viewController = [[Ad728_090ViewController alloc] init];
                break;
                
            default:
                break;
        }
    }
    
    viewController.view.backgroundColor = [UIColor whiteColor];
    viewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    [self.navigationController pushViewController:viewController animated:YES];
}


@end
