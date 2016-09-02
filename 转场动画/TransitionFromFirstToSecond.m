//
//  TransitionFromFirstToSecond.m
//  转场动画
//
//  Created by 赖天翔 on 16/3/24.
//  Copyright © 2016年 赖天翔. All rights reserved.
//

#import "TransitionFromFirstToSecond.h"
#import "FirstViewController.h"
#import "SecViewController.h"
#import "CollectionViewCell.h"
@implementation TransitionFromFirstToSecond
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    //拿到从哪里来的vc
    FirstViewController * fromVC = (FirstViewController*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //拿到到哪里去的vc
    SecViewController * toVC = (SecViewController*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView * containerView = [transitionContext containerView];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    //拿到cell
    
    CollectionViewCell * cell = (CollectionViewCell*)[fromVC.collectionView cellForItemAtIndexPath:[[fromVC.collectionView indexPathsForSelectedItems] firstObject]];
    //cell图片的截图
    UIView * cellImageSnapshot = [cell.imageView snapshotViewAfterScreenUpdates:NO];
//    UIView * navi = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 64)];
//    navi.backgroundColor = [UIColor blackColor];
    UIView * naviView = [fromVC.navigationController.navigationBar snapshotViewAfterScreenUpdates:NO];
    
        // 将rect从view中转换到当前视图中，返回在当前视图中的rect
     cellImageSnapshot.frame = [containerView convertRect:cell.imageView.frame fromView:cell.imageView.superview];
   // naviView.frame = [containerView convertRect:fromVC.navigationController.navigationBar.frame fromView:fromVC.navigationController.navigationBar.superview];少了statusBar部分;
    naviView.frame = CGRectMake(0, -1, 320, 64);
  
    
    
    //跳转的时候cell的图片隐藏起来
    cell.imageView.hidden = YES;
    fromVC.navigationController.navigationBarHidden = YES;
    
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.alpha = 0;
    toVC.imageView.hidden = YES;
    
    [containerView addSubview:toVC.view];
    [containerView addSubview:cellImageSnapshot];
    [containerView addSubview:naviView];
    
    
    
    [UIView animateWithDuration:duration animations:^{
        fromVC.view.alpha = 0;
        toVC.view.alpha = 1.0;
        CGRect frame = [containerView convertRect:toVC.imageView.frame fromView:toVC.view];
        naviView.frame = CGRectMake(0, -64, 320, 64);
        
        cellImageSnapshot.frame = frame;
    } completion:^(BOOL finished) {
        fromVC.navigationController.navigationBarHidden = NO;
        
//        UIBezierPath *originPath = [UIBezierPath bezierPathWithOvalInRect:toVC.imageView.frame];
//        float radius = 500;
//        UIBezierPath *finalPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(toVC.imageView.frame, -radius, -radius)];
//        
//        CAShapeLayer *maskLayer = [CAShapeLayer layer];
//        maskLayer.fillColor = [UIColor blueColor].CGColor;
//        maskLayer.path = finalPath.CGPath;
//        toVC.view.layer.mask = maskLayer;
//        
//        
//        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
//        animation.fromValue = (__bridge id _Nullable)(originPath.CGPath);
//        animation.toValue = (__bridge id _Nullable)(finalPath.CGPath);
//        animation.duration = 1.5;
//     
//        [maskLayer addAnimation:animation forKey:@"path"];
    
        toVC.view.alpha = 1.0;
        
        
        
        toVC.imageView.hidden = NO;
        cell.hidden = NO;
        [cellImageSnapshot removeFromSuperview];
        
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        
        
        

    }];
    

    
}
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.4;
}
@end
