//
//  VideoNativeViewController.h
//  ObjC_Example
//
//  Copyright © 2018年 FAN Communications. All rights reserved.
//

#import <UIKit/UIKit.h>

@import NendAd;

@interface VideoNativeViewController : UIViewController

@property (nonatomic, weak) IBOutlet NADNativeVideoView *videoView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, weak) IBOutlet UILabel *advertiserNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *userRatingLabel;
@property (nonatomic, weak) IBOutlet UILabel *userRatingCountLabel;
@property (nonatomic, weak) IBOutlet UIImageView *logoImageView;
@property (nonatomic, weak) IBOutlet UIButton *callToActionButton;

@end
