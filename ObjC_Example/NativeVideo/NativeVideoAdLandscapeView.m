//
//  NativeVideoAdLandscapeView.m
//  ObjC_Example
//
//  Created by 馬場美沙都 on 2023/05/09.
//  Copyright © 2023 F@N Communications. All rights reserved.
//
#import "NativeVideoAdLandscapeView.h"

@implementation NativeVideoAdLandscapeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadXib];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self loadXib];
    }
    return self;
}

- (void) loadXib
{
    UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"NativeVideoAdLandscapeView" owner:self options:nil] firstObject];
    [self addSubview: view];
}

@end
