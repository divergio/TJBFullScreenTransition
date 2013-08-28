//
//  UIViewController+TJBFullScreenTransition.m
//  iMatchBox
//
//  Created by Tyler Barth on 2013-05-29.
//  Copyright (c) 2013年 Gabble. All rights reserved.
//

#import "UIViewController+TJBFullScreenTransition.h"
#import "UIView+TJBExpandingView.h"

#import "objc/runtime.h"

@implementation UIViewController (TJBFullScreenTransition)

static char WINDOW;
static char PRESENTING;
static char PRESENTED;
static char TRANSITION_STYLE;
static char START_FRAME;
static char END_FRAME;
static char ALPHA;

#pragma mark - Method Implementations

- (void) presentViewControllerFullScreen:(UIViewController *)viewControllerToPresent animated:(BOOL)animated completion:(void (^)(void))completion
{
    //Setup trail of view controllers
    [viewControllerToPresent setFullScreenPresentingVC:self];
    [self setFullScreenPresentedVC:viewControllerToPresent];
    
    [self.fullScreenWindow setRootViewController:viewControllerToPresent];
    
    self.fullScreenWindow.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:[viewControllerToPresent fullScreenBackgroundAlpha]];
    
    [self.fullScreenWindow makeKeyAndVisible];
    
    //Reset frame because it keeps adding the status bar
    [viewControllerToPresent.view setFrame:[viewControllerToPresent fullScreenStartFrame]];
    
    NSTimeInterval duration = 0.3f;
    if ([self isFadeIn:animated forVC:viewControllerToPresent])
        duration = 0.0f;
    
    [UIView animateWithDuration:duration delay:0.0f options:UIViewAnimationOptionTransitionNone animations:^() {
        self.fullScreenWindow.alpha = 1.0f;
    } completion:^(BOOL finished) {
        BOOL expandAnimation = [self isExpand:animated forVC:viewControllerToPresent];
        [viewControllerToPresent.view expandToFrame:[[UIScreen mainScreen] bounds] animated:expandAnimation completion:completion];
    }];
}

- (void) dismissViewControllerFullScreenAnimated:(BOOL)animated completion:(void (^)(void))completion
{
    if (!self.fullScreenPresentedVC) {
        [self.fullScreenPresentingVC dismissViewControllerFullScreenAnimated:animated completion:completion];
    } else {
        
        UIViewController *vc = self.fullScreenPresentedVC;
        
        TJBFullScreenTransitionStyle style = [vc fullScreenTransitionStyle];
        
        NSTimeInterval duration = 0.3f;
        if (!animated ||
            !(style & TJBFullScreenTransitionStyleFading)) {
            duration = 0.0f;
        }
        
        [self.fullScreenPresentedVC.view shrinkToFrame:[vc fullScreenEndFrame] animated:[self isExpand:animated forVC:self.fullScreenPresentedVC] completion:^{
            
            [UIView animateWithDuration:duration delay:0.0f options:UIViewAnimationOptionTransitionNone animations:^() {
                self.fullScreenWindow.alpha = 0.0f;
            } completion:^(BOOL finished) {
                self.fullScreenWindow.hidden = YES;
                self.fullScreenWindow = nil;
                completion();
            }];
        }];
    }
}

#pragma mark - Helper methods

- (BOOL) isFadeIn:(BOOL)animated forVC:(UIViewController*)vc
{
    return (animated && ([vc fullScreenTransitionStyle] & TJBFullScreenTransitionStyleFading));
}

- (BOOL) isExpand:(BOOL)animated forVC:(UIViewController*)vc
{
    return (animated && ([vc fullScreenTransitionStyle] & TJBFullScreenTransitionStyleExpanding));
}

#pragma mark - Associated Reference Property Implementations

//This is a lot of boiler plate, plus the default values.

- (void) setFullScreenTransitionStyle:(TJBFullScreenTransitionStyle)fullScreenTransitionStyle
{
    objc_setAssociatedObject(self, &TRANSITION_STYLE, [NSNumber numberWithInt:fullScreenTransitionStyle], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (TJBFullScreenTransitionStyle) fullScreenTransitionStyle
{
    NSNumber* style = objc_getAssociatedObject(self, &TRANSITION_STYLE);
    if (!style) {
        return (TJBFullScreenTransitionStyleExpanding | TJBFullScreenTransitionStyleFading);
    }
    return [style intValue];
}

- (void) setFullScreenStartFrame:(CGRect)fullScreenStartFrame
{
    objc_setAssociatedObject(self, &START_FRAME, [NSValue valueWithCGRect:fullScreenStartFrame],OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGRect) fullScreenStartFrame
{
    NSValue *value = objc_getAssociatedObject(self, &START_FRAME);
    if (!value) {
        //This is not sensitive to orientation changes
        CGRect screen = [[UIScreen mainScreen] bounds];
        return CGRectMake(0.0f, screen.size.height/2, screen.size.width, 1.0f);
    }
    return [value CGRectValue];
}

- (void) setFullScreenEndFrame:(CGRect)fullScreenEndFrame
{
    objc_setAssociatedObject(self, &END_FRAME, [NSValue valueWithCGRect:fullScreenEndFrame],OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGRect) fullScreenEndFrame
{
    NSValue *value = objc_getAssociatedObject(self, &END_FRAME);
    if (!value) {
        return [self fullScreenStartFrame];
    }
    return [value CGRectValue];
}

- (void) setFullScreenBackgroundAlpha:(CGFloat)backgroundAlpha
{
    objc_setAssociatedObject(self, &ALPHA, [NSNumber numberWithFloat:backgroundAlpha],OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat) fullScreenBackgroundAlpha
{
    NSNumber *number = objc_getAssociatedObject(self, &ALPHA);
    if (!number)
        return 0.7f;
    return [number floatValue];
}

//Using associative reference to fake category ivars
- (void) setFullScreenWindow:(UIWindow *)window
{
    objc_setAssociatedObject(self, &WINDOW, window, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIWindow*) fullScreenWindow
{
    UIWindow* window = objc_getAssociatedObject(self, &WINDOW);
    
    if (!window) {
        window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        window.windowLevel = UIWindowLevelStatusBar + 1;
        [window setAlpha:0.0f];
        [self setFullScreenWindow:window];
    }
    
    return window;
}

- (void) setFullScreenPresentingVC:(UIViewController *)fullScreenPresentingVC
{
    objc_setAssociatedObject(self, &PRESENTING, fullScreenPresentingVC, OBJC_ASSOCIATION_ASSIGN);
}

- (UIViewController*) fullScreenPresentingVC
{
    UIViewController* presenting = objc_getAssociatedObject(self, &PRESENTING);
    //Recurse to find parent
    if (!presenting) {
        if (self.presentingViewController) {
            return [[self presentingViewController] fullScreenPresentingVC];
        } else if (self.parentViewController) {
            return [[self parentViewController] fullScreenPresentingVC];
        }
    }
    return presenting;
}

- (void) setFullScreenPresentedVC:(UIViewController *)fullScreenPresentedVC
{
    objc_setAssociatedObject(self, &PRESENTED, fullScreenPresentedVC, OBJC_ASSOCIATION_ASSIGN);
}

- (UIViewController*) fullScreenPresentedVC
{
    return objc_getAssociatedObject(self, &PRESENTED);
}

@end