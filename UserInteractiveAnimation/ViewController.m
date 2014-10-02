//
//  ViewController.m
//  UserInteractiveAnimation
//
//  Created by Xinrong Guo on 14-10-2.
//  Copyright (c) 2014年 FoOTOo. All rights reserved.
//

#import "ViewController.h"
#import "CALayer+GSAnimationControl.h"

static const CFTimeInterval kAnimationDuration = 3;

@interface ViewController ()

@property (strong, nonatomic) UIView *moveableView;

@property (assign, nonatomic) CFTimeInterval animationProgress;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // View
    _moveableView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100)];
    [self.moveableView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:self.moveableView];
    
    // Gesture
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [self.view addGestureRecognizer:panGesture];
    
    [self switchToState1];
}

- (void)switchToState1 {
    [self.moveableView setCenter:CGPointMake(self.view.bounds.size.width / 2, 50)];
    [self.moveableView setTag:1];
}

- (void)switchToState2 {
    [self.moveableView setCenter:CGPointMake(self.view.bounds.size.width / 2, 500)];
    [self.moveableView setTag:2];
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)panGesture {
    if (panGesture.state == UIGestureRecognizerStateBegan) {
        [self.moveableView.layer removeAllAnimations];
        
        [UIView animateWithDuration:kAnimationDuration animations:^{
            if (self.moveableView.tag == 1) {
                [self switchToState2];
            }
            else {
                [self switchToState1];
            }
        } completion:^(BOOL finished) {
            [self.moveableView.layer gs_recoverToDefaultState];
            
            if (self.animationProgress <= 0.5) {
                if (self.moveableView.tag == 1) {
                    [self switchToState2];
                }
                else {
                    [self switchToState1];
                }
            }
        }];
        
        [self.moveableView.layer gs_pauseAnimation];
    }
    else if (panGesture.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [panGesture translationInView:self.view];
        CGFloat length = ABS(translation.y);
        
        self.animationProgress = MAX(0, MIN(length / 500, 1));
        
        [self.moveableView.layer gs_setTimeProgress:self.animationProgress *  kAnimationDuration];
    }
    else if (panGesture.state == UIGestureRecognizerStateEnded || panGesture.state == UIGestureRecognizerStateFailed || panGesture.state == UIGestureRecognizerStateCancelled) {
        
        if (self.animationProgress > 0.5) {
            [self.moveableView.layer gs_continueAnimationWithTimeProgress:self.animationProgress * kAnimationDuration];
        }
        else {
            [self.moveableView.layer gs_continueReverseAnimationWithTimeProgress:self.animationProgress * kAnimationDuration animationDuration:kAnimationDuration];
        }
    }
}

@end
