//
//  SelectInterstitialTableViewController.m
//  NendSDK_Sample
//
//  Copyright © 2016年 F@N Communications. All rights reserved.
//

#import "SelectInterstitialTableViewController.h"
#import "AdInterstitialViewController.h"
#import "AdInterstitialInTransitionViewController.h"

static NSString *const CellIdentifier = @"Cell";

@interface SelectInterstitialTableViewController()

@property (nonatomic) NSArray<NSString *> *items;

@end

@implementation SelectInterstitialTableViewController

- (void)viewDidLoad{
    self.title = @"Interstitial";
    
    self.items = @[ @"default", @"in transition" ];
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
    cell.textLabel.text = self.items[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            [self performSegueWithIdentifier:@"PushInterstitial" sender:indexPath];
            break;
        case 1:
            [self performSegueWithIdentifier:@"PushInTransition" sender:indexPath];
            break;
        default:
            break;
    }
}

@end
