//
//  UINavigationController+Rotation.m
//  NendSDK_Sample
//
//  Copyright (c) 2013年 F@N Communications. All rights reserved.
//

#import "UINavigationController+Rotation.h"

@implementation UINavigationController (Rotation)

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

@end
