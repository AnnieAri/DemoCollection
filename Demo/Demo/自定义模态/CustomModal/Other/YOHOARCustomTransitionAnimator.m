//
//  YOHOARCustomTransitionAnimator.m
//  YOHOMars
//
//  Created by Ari on 16/9/25.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "YOHOARCustomTransitionAnimator.h"
#import "YOHOCommentBigPicViewController.h"
#import "YOHOHomeController.h"
typedef enum : NSUInteger {
    MusicAnimatorTypeModal,
    MusicAnimatorTypeDismiss,
} MusicAnimatorType;

@interface YOHOARCustomTransitionAnimator () <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) MusicAnimatorType type;

@end

@implementation YOHOARCustomTransitionAnimator

// 跳转页面时候执行的代理方法
- (nullable id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController*)presented presentingController:(UIViewController*)presenting sourceController:(UIViewController*)source
{
    self.type = MusicAnimatorTypeModal;
    return self;
}

// 关闭页面时候执行的代理方法
- (nullable id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController*)dismissed
{
    self.type = MusicAnimatorTypeDismiss;
    return self;
}

// 设置转场动画的时间
- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1.0;
}

// 跳转和关闭 都会调用这个方法
// transitionContext 所有需要跳转做动画的信息都在这个上下文中
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    
    // 获取到容器视图
    UIView* containerView = [transitionContext containerView];
    
    // 获取跳转到的控制器
    UIViewController* toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    // 获取到from的控制器
    UIViewController* fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    switch (self.type) {
        case MusicAnimatorTypeModal: {
            // 把跳转到的控制器的view添加到容器视图当中
            YOHOCommentBigPicViewController * tVC = (YOHOCommentBigPicViewController *)toVC;
            [containerView addSubview:toVC.view];
            toVC.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
            toVC.view.backgroundColor = [UIColor clearColor];
            // 设置跳转到的控制器的view 以上来在负的某个角度(看不见)
            
            tVC.PicView.frame = self.toVCPicFrame;
            NSLog(@"%@",NSStringFromCGRect(self.toVCPicFrame));
            //    toVC.view.alpha = 0;
            CGFloat picViewWH = kScreenWidth;
            CGFloat picViewX = 0;
            CGFloat picViewY = (kScreenHeight - picViewWH) / 2;
            [UIView animateWithDuration:.25 animations:^{
                tVC.PicView.frame = CGRectMake(picViewX, picViewY, picViewWH, picViewWH);
                toVC.view.backgroundColor = [UIColor blackColor];
                tVC.toolBarView.alpha = 1;
                tVC.descView.alpha = 1;
            } completion:^(BOOL finished) {
                // 告诉系统已经做完了转场动画,如果不告诉系统,系统会一直等待转场结束,才允许交互
               
                [transitionContext completeTransition:YES];
            }];
            
            
            break;
        }
        case MusicAnimatorTypeDismiss: {
            NSLog(@"跳转");
            YOHOCommentBigPicViewController *fVC  = (YOHOCommentBigPicViewController *)fromVC;
           [UIView animateWithDuration:.25 animations:^{
               fVC.PicView.frame = self.toVCPicFrame;
               fVC.view.backgroundColor = [UIColor clearColor];
               fVC.toolBarView.alpha = 0;
               fVC.descView.alpha = 0;
           } completion:^(BOOL finished) {
               [transitionContext completeTransition:YES];
           }];
            
        } break;
            
        default:
            break;
    }
}
@end
