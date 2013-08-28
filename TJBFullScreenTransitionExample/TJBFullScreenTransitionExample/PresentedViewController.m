//
//  PresentingViewController.m
//  TJBFullScreenTransitionExample
//
//  Created by Tyler Barth on 2013-05-31.
//  Copyright (c) 2013年 divergio. All rights reserved.
//

#import "PresentedViewController.h"
#import "UIViewController+TJBFullScreenTransition.h"
#import "UIViewController+FillViewWithChildVC.h"

@interface PresentedViewController ()

@property (nonatomic, strong) IBOutlet UITextView* text;

@property (nonatomic, weak) IBOutlet UIImageView* imageView;

@end

@implementation PresentedViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
   [self.imageView setImage:[[UIImage imageNamed:@"amateur_chat_bubble.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(10,4,51,7)]];
    
    [self.text setText:self.labelContents];
}

- (IBAction)close:(id)sender
{
    [self dismissViewControllerFullScreenAnimated:YES completion:^{}];
}

@end
