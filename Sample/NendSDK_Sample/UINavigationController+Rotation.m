//
//  UINavigationController+Rotation.m
//  NendSDK_Sample
//
//  Created by ADN on 2014/11/06.
//  Copyright (c) 2013年 F@N Communications. All rights reserved.
//

#import "UINavigationController+Rotation.h"


@implementation UINavigationController (Rotation)

- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotate{
    return YES;
}

@end
