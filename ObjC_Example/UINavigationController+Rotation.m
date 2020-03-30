//
//  UINavigationController+Rotation.m
//  ObjC_Example
//
//  Copyright (c) 2013年 FAN Communications. All rights reserved.
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
