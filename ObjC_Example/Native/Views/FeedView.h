//
//  FeedView.h
//  ObjC_Example
//
//  Copyright © 2015年 FAN Communications. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedView : UIView

@property (nonatomic, copy) NSString *titleText;
@property (nonatomic, copy) NSString *categoryText;
@property (nonatomic, copy) NSString *link;
@property (nonatomic) BOOL adLoading;

@end
