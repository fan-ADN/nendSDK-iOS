//
//  FullBoardAdContentViewController.m
//  NendSDK_Sample
//
//  Created by user on 2017/01/18.
//  Copyright © 2017年 F@N Communications. All rights reserved.
//

#import "FullBoardAdContentViewController.h"

@interface FullBoardAdContentViewController ()

@property (weak, nonatomic) IBOutlet UILabel *pageLabel;
@property (weak, nonatomic) NSString *number;

@end

@implementation FullBoardAdContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _pageLabel.text = self.number;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setNumber:(NSString *)number
{
    _number = number;
    

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
