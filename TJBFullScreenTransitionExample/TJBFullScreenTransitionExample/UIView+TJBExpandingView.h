//
//  UIView+TJBExpandingView.h
//  iMatchBox
//
//  Created by Tyler Barth on 2013-05-29.
//  Copyright (c) 2013年 Gabble. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (TJBExpandingView)

- (void) expandToFrame:(CGRect)frame animated:(BOOL)animated completion:(void (^)(void))completion;
- (void) shrinkToFrame:(CGRect)frame animated:(BOOL)animated completion:(void (^)(void))completion;

@end
