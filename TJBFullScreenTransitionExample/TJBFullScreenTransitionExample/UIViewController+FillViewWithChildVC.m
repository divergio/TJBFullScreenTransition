//
//  UIViewController+FillViewWithChildVC.m
//  iMatchBox
//
//  Created by Tyler Barth on 2013-05-28.
//  Copyright (c) 2013年 Gabble. All rights reserved.
//

#import "UIViewController+FillViewWithChildVC.h"

@implementation UIViewController (FillViewWithChildVC)

- (void) fillViewWithChildVC:(UIViewController *)childVC
{
    [self addChildViewController:childVC];
    
    [self.view addSubview:childVC.view];
    [childVC.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSDictionary *viewsDictionary = @{@"child" : childVC.view};
    
    NSArray *horizontalConstraints =
    [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[child]|"
                                            options:0
                                            metrics:nil
                                              views:viewsDictionary];
    NSArray *verticalConstraints =
    [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[child]|"
                                            options:0
                                            metrics:nil
                                              views:viewsDictionary];
    
    [self.view addConstraints:horizontalConstraints];
    [self.view addConstraints:verticalConstraints];
    
    [childVC didMoveToParentViewController:self];
}

@end
