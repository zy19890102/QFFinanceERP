//
//  ZYFadeTransion.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/12.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYFadeTransion.h"

@implementation ZYFadeTransion
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3f;
}
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    
    UIView *container = [transitionContext containerView];
    UIViewController *toController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    toController.view.frame = [transitionContext finalFrameForViewController:toController];
    toController.view.alpha = 0;
    [container addSubview:toController.view];
    
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toController.view.alpha = 1;
    } completion:^(BOOL finished) {
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}
@end
