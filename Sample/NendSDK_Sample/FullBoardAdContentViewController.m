//
//  FullBoardAdContentViewController.m
//  NendSDK_Sample
//
//  Copyright © 2017年 F@N Communications. All rights reserved.
//

#import "FullBoardAdContentViewController.h"

@interface FullBoardAdContentViewController ()

@property (weak, nonatomic) IBOutlet UILabel *pageLabel;

@end

@implementation FullBoardAdContentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _pageLabel.text = self.number;
}

@end
