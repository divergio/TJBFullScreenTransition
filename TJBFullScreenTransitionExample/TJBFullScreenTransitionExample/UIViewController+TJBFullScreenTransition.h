//
//  UIViewController+TJBFullScreenTransition.h
//  iMatchBox
//
//  Created by Tyler Barth on 2013-05-29.
//  Copyright (c) 2013年 Gabble. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    TJBFullScreenTransitionStyleNone,
    TJBFullScreenTransitionStyleFading,
    TJBFullScreenTransitionStyleExpanding,
} TJBFullScreenTransitionStyle;

@interface UIViewController (TJBFullScreenTransition)

- (void) presentViewControllerFullScreen:(UIViewController *)viewControllerToPresent animated:(BOOL)animated completion:(void (^)(void))completion;

- (void) dismissViewControllerFullScreenAnimated:(BOOL)animated completion:(void (^)(void))completion;


//The style to use for transitioning to/from fullscreen, default is
// (TJBFullScreenTransitionStyleFading | TJBFullScreenTransitionStyleExpanding)
@property (nonatomic, assign) TJBFullScreenTransitionStyle fullScreenTransitionStyle;

//The start and ending frames for the expanding/contracting style
//Note: not the end frame of the expansion. The end frame is always the entire screen.

//Start frame is the frame the expanding animation should start from
@property (nonatomic, assign) CGRect fullScreenStartFrame; //Default is center of screen

//End frame is the frame the contracting (on dismiss) frame should end at
@property (nonatomic, assign) CGRect fullScreenEndFrame; //default is start frame

//The alpha to use for the endpoint of the fading animation and the background of the new frame
//Default is 0.7f, set to 0.0f with no animation if you want to do your own fading
@property (nonatomic, assign) CGFloat fullScreenBackgroundAlpha;

//Private
@property (nonatomic, strong) UIWindow* fullScreenWindow;
@property (nonatomic, strong) UIViewController *fullScreenPresentingVC;
@property (nonatomic, strong) UIViewController *fullScreenPresentedVC;



@end
