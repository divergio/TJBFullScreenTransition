//
//  UIView+TJBExpandingView.m
//  iMatchBox
//
//  Created by Tyler Barth on 2013-05-29.
//  Copyright (c) 2013年 Gabble. All rights reserved.
//

#import "UIView+TJBExpandingView.h"

@implementation UIView (TJBExpandingView)

- (void) expandToFrame:(CGRect)frame animated:(BOOL)animated completion:(void (^)(void))completion;
{
    NSTimeInterval durationExpand = 0.3f;
    NSTimeInterval delayExpand = 0.2f;
    if (!animated) {
        durationExpand = 0.0f;
        delayExpand = 0.0f;
    }
    
    [UIView animateWithDuration:durationExpand delay:delayExpand options:UIViewAnimationOptionLayoutSubviews animations:^{
        [self setFrame:frame];
    } completion:^(BOOL finished) {
        completion();
    }];
}

- (void) shrinkToFrame:(CGRect)frame animated:(BOOL)animated completion:(void (^)(void))completion;
{
    NSTimeInterval durationExpand = 0.25f;
    NSTimeInterval delayExpand = 0.2f;
    if (!animated) {
        durationExpand = 0.0f;
        delayExpand = 0.0f;
    }
    
    [UIView animateWithDuration:durationExpand delay:delayExpand options:UIViewAnimationOptionLayoutSubviews animations:^{
        [self setFrame:frame];
    } completion:^(BOOL finished) {
        completion();
    }];
}
@end
