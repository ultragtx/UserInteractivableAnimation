//
//  CALayer+GSAnimationControl.m
//  UserInteractiveAnimation
//
//  Created by Xinrong Guo on 14-10-2.
//  Copyright (c) 2014年 FoOTOo. All rights reserved.
//

#import "CALayer+GSAnimationControl.h"

@implementation CALayer (GSAnimationControl)

- (void)gs_pauseAnimation {
    self.speed = 0;
    self.timeOffset = 0;
}

- (void)gs_recoverToDefaultState {
    self.speed = 1;
    self.timeOffset = 0;
    self.beginTime = 0;
}

- (void)gs_setTimeProgress:(CFTimeInterval)timeProgress {
    self.timeOffset = timeProgress;
}

- (void)gs_continueAnimationWithTimeProgress:(CFTimeInterval)timeProgress {
    [self gs_recoverToDefaultState];
    
    self.beginTime = [self convertTime:CACurrentMediaTime() fromLayer:nil] - timeProgress;
}

- (void)gs_continueReverseAnimationWithTimeProgress:(CFTimeInterval)timeProgress animationDuration:(CFTimeInterval)duration {
    [self gs_recoverToDefaultState];
    
    self.beginTime = [self convertTime:CACurrentMediaTime() fromLayer:nil] - (duration - timeProgress);
    self.timeOffset = duration;
    self.speed = -1;
}

@end
