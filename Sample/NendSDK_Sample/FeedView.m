//
//  FeedView.m
//  NendSDK_Sample
//
//  Copyright © 2015年 F@N Communications. All rights reserved.
//

#import "FeedView.h"

@interface FeedView ()

@property (nonatomic, weak) IBOutlet UILabel *title;
@property (nonatomic, weak) IBOutlet UILabel *category;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *indicator;

@end

@implementation FeedView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [self addGestureRecognizer:recognizer];
    
    if (@available(iOS 13.0, *)) {
        self.backgroundColor = [UIColor colorNamed:@"NativeAdBackgroundColor"];
        self.title.textColor = [UIColor colorNamed:@"TextColor"];
        self.category.textColor = [UIColor colorNamed:@"TextColor"];
    }
}

- (void)setTitleText:(NSString *)titleText
{
    self.title.text = titleText;
}

- (void)setCategoryText:(NSString *)categoryText
{
    self.category.text = categoryText;
}

- (void)setAdLoading:(BOOL)adLoading
{
    if (!self.indicator) {
        return;
    }
    if (adLoading) {
        self.title.text = @"";
        self.category.text = @"";
        [self.indicator startAnimating];
        self.indicator.hidden = NO;
    } else {
        [self.indicator stopAnimating];
        self.indicator.hidden = YES;
    }
}

- (void)tapped:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.link]];
}


@end
