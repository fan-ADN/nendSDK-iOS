//
//  SelectTableViewController.m
//  NendSDK_Sample
//
//  Created by ADN on 2013/07/19.
//  Copyright (c) 2013年 F@N Communications. All rights reserved.
//

#import "SelectTableViewController.h"

#import "Ad320_050ViewController.h"
#import "Ad320_100ViewController.h"
#import "Ad300_100ViewController.h"
#import "Ad300_250ViewController.h"
#import "Ad728_090ViewController.h"
#import "AdIconViewController.h"
#import "AdInterstitialViewController.h"

@interface SelectTableViewController ()

@end

@implementation SelectTableViewController

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

- (void)didReceiveMemoryWarning
{
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
    return 7;
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

        case 5:
            [cell.textLabel setText:@"Icon"];
            break;

        case 6:
            [cell.textLabel setText:@"Interstitial"];
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

        case 5:
            viewController = [[AdIconViewController alloc] init];
            break;

        case 6:
            viewController = [[AdInterstitialViewController alloc] init];
            break;

        default:
            break;
    }
    
    viewController.view.backgroundColor = [UIColor whiteColor];
    viewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
