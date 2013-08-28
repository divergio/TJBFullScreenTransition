//
//  PresentingViewController.h
//  TJBFullScreenTransitionExample
//
//  Created by Tyler Barth on 2013-05-31.
//  Copyright (c) 2013年 divergio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PresentedViewController : UIViewController

@property (nonatomic, strong) NSString *labelContents;

- (IBAction)close:(id)sender;

@end
