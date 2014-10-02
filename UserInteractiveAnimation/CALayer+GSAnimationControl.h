//
//  CALayer+GSAnimationControl.h
//  UserInteractiveAnimation
//
//  Created by Xinrong Guo on 14-10-2.
//  Copyright (c) 2014年 FoOTOo. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (GSAnimationControl)

- (void)gs_pauseAnimation;
- (void)gs_recoverToDefaultState;
- (void)gs_setTimeProgress:(CFTimeInterval)timeProgress;
- (void)gs_continueAnimationWithTimeProgress:(CFTimeInterval)timeProgress;
- (void)gs_continueReverseAnimationWithTimeProgress:(CFTimeInterval)timeProgress animationDuration:(CFTimeInterval)duration;

@end
