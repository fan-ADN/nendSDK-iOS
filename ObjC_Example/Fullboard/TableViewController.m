//
//  TableViewController.m
//  ObjC_Example
//
//  Copyright © 2017年 FAN Communications. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()

@property (nonatomic) NSMutableArray<NSString *> *items;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    self.tableView.allowsSelection = NO;
    self.items = [NSMutableArray array];
    for (NSInteger i = 1; i <= 50; i++) {
        [self.items addObject:[NSString stringWithFormat:@"Item%ld", (long)i]];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
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

@end
