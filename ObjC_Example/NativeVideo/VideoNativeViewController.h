//
//  VideoNativeViewController.h
//  ObjC_Example
//
//  Created by 馬場美沙都 on 2023/05/11.
//  Copyright © 2023 F@N Communications. All rights reserved.
//
@interface VideoNativeViewController: UIViewController <NADNativeVideoViewDelegate, NADNativeVideoDelegate>

@property (weak, nonatomic) IBOutlet UIView *container;

@end
