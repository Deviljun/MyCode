//
//  TransitionFromSecondToFirst.m
//  转场动画
//
//  Created by 赖天翔 on 16/3/24.
//  Copyright © 2016年 赖天翔. All rights reserved.
//

#import "TransitionFromSecondToFirst.h"

#import "FirstViewController.h"
#import "SecViewController.h"
#import "CollectionViewCell.h"
@implementation TransitionFromSecondToFirst
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    SecViewController * fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    FirstViewController * toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView * containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    UIView * imageSnapshot = [fromVC.imageView snapshotViewAfterScreenUpdates:NO];
    imageSnapshot.frame = [containerView convertRect:fromVC.imageView.frame fromView:fromVC.imageView.superview];
    
    fromVC.imageView.hidden = YES;
    
    CollectionViewCell * cell = (CollectionViewCell*)[toVC.collectionView cellForItemAtIndexPath:[[toVC.collectionView indexPathsForSelectedItems] firstObject]];
    cell.imageView.hidden = YES;
    
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.alpha = 0;
    
    [containerView insertSubview:toVC.view aboveSubview:fromVC.view];
    [containerView addSubview:imageSnapshot];
    
    
    
    [UIView animateWithDuration:duration animations:^{
        //fromVC.view.alpha = 0.0;
        toVC.view.alpha = 1.0;
        imageSnapshot.frame = [containerView convertRect:cell.imageView.frame fromView:cell.imageView.superview];
    } completion:^(BOOL finished) {
        [imageSnapshot removeFromSuperview];
        fromVC.imageView.hidden = NO;
        cell.imageView.hidden = NO;
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
    
    
}
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}
@end
