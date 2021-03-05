//
//  SelectTableViewController.m
//  ObjC_Example
//
//  Copyright (c) 2013年 FAN Communications. All rights reserved.
//

#import "SelectTableViewController.h"

#import "SelectBannerTableViewController.h"
#import "AdInterstitialViewController.h"
#import "NativeAdViewController.h"

@import AppTrackingTransparency;

static NSString *const CellIdentifier = @"Cell";

@interface SelectTableViewController ()

@property (nonatomic) NSArray<NSString *> *items;

@end

@implementation SelectTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"ObjCExample";

    self.items = @[ @"Banner", @"Interstitial", @"Native", @"FullBoard", @"Video", @"VideoNative" ];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    
    if (@available(iOS 14.0, *)) {
        [self usingATTConsentDialog];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)usingATTConsentDialog API_AVAILABLE(ios(14.0)) {
    if ([ATTrackingManager trackingAuthorizationStatus] == ATTrackingManagerAuthorizationStatusNotDetermined) {
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            switch (status) {
                case ATTrackingManagerAuthorizationStatusAuthorized:
                case ATTrackingManagerAuthorizationStatusDenied:
                case ATTrackingManagerAuthorizationStatusNotDetermined:
                case ATTrackingManagerAuthorizationStatusRestricted:
                    break;
                default:
                    break;
            }
        }];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    // Configure the cell...
    cell.textLabel.text = self.items[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [NSString stringWithFormat:@"Push%@", self.items[indexPath.row]];
    [self performSegueWithIdentifier:identifier sender:nil];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *viewController = segue.destinationViewController;
    viewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
}

@end
