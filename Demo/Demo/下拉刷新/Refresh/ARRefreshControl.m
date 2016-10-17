//
//  ARRefreshControl.m
//  ARRefreshDemo
//
//  Created by Ari on 16/9/25.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "ARRefreshControl.h"
#import "NSObject+Formula.h"
#import "UIImage+loadImage.h"

#define kARRefreshContrlH 44

@interface ARRefreshControl ()
//记录控件状态  默认为 默认状态
@property (nonatomic,assign) ARRefresgType refreshState;
//用于记录父控件
@property (nonatomic,weak) UIScrollView *scrollView;
//加载动画
@property (nonatomic,strong) UIImageView *loadImage;
@property (nonatomic,assign) NSInteger imageNum;
@property (nonatomic,assign) BOOL istabelViewBack;
@end
@implementation ARRefreshControl
//结束刷新的方法 供外界调用
- (void)endRefreshing{
    self.refreshState = ARRefresgTypeNormal;
}
//获取父控件
- (void)willMoveToSuperview:(UIView *)newSuperview {
    //记录
    self.scrollView = (UIScrollView *)newSuperview;
    //添加观察者
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:nil];
}
#pragma mark - 注销kvo
//- (void)dealloc {
//    NSLog(@"dealloc");
//}
//- (void)removeFromSuperview {
//    NSLog(@"");
//    [self.scrollView removeObserver:self forKeyPath:@"contentOffset" context:nil];
//
//    [super removeFromSuperview];
//}
- (void)removeObserver {
    NSLog(@"removeObserver");
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset" context:nil];
}
//观察者 监听事件
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    CGFloat contentInsetTop = self.scrollView.contentInset.top;
    CGFloat conditionValue = -contentInsetTop - kARRefreshContrlH;
    
    if (self.scrollView.isDragging) {
        //用户在拖动时
        //如果处于默认状态并且完全显示出来  状态更改为 拉动状态
        if (self.refreshState == ARRefresgTypeNormal && self.scrollView.contentOffset.y < conditionValue) {
            self.refreshState = ARRefresgTypePulling;
        } else if (self.refreshState == ARRefresgTypePulling && self.scrollView.contentOffset.y > conditionValue){
            self.refreshState = ARRefresgTypeNormal;
        }
    }else{
        //用户没有拖动
        if (self.refreshState == ARRefresgTypePulling) {
            self.refreshState = ARRefresgTypeRefreshing;
        }
    }
    //改变imageview的图片
    CGFloat offsetY = self.scrollView.contentOffset.y  < conditionValue ? conditionValue : self.scrollView.contentOffset.y;
    CGFloat imageNum = ((offsetY) / (conditionValue )) * 22;
    if (imageNum < 12) {
        imageNum = 12;
    }
    YHValue consultValue = YHValueMake(12, 22);
    YHValue resultValue = YHValueMake(0, 10);
    NSInteger result = [NSObject resultWithConsult:imageNum andResultValue:resultValue andConsultValue:consultValue];
    if (self.imageNum != result && self.state == ARRefresgTypeNormal && self.istabelViewBack) {
        self.loadImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"loading%zd",result]];
        self.imageNum = result;
    }
}
//更该本控件的状态
- (void)setRefreshState:(ARRefresgType)refreshState {
    ARRefresgType oldValue = _refreshState;
    _refreshState = refreshState;
    switch (refreshState) {
            //默认状态
        case ARRefresgTypeNormal:{
            self.loadImage.image = [UIImage imageNamed:@"loading0"];
            //箭头显示出来
            //判断是不是从刷新进来的
            if (oldValue == ARRefresgTypeRefreshing) {
                [UIView animateWithDuration:0.25 animations:^{
                    UIEdgeInsets inset = self.scrollView.contentInset;
                    inset.top -= kARRefreshContrlH;
                    self.scrollView.contentInset = inset;
                }completion:^(BOOL finished) {
                    self.istabelViewBack = true;
                }];
            }
            break;
        }
            //拖动状态
        case ARRefresgTypePulling:{

            break;
        }
            //正在刷新的状态
        case ARRefresgTypeRefreshing:{
            self.istabelViewBack = false;
            self.loadImage.image = [UIImage ari_loadImage];
            [UIView animateWithDuration:0.25 animations:^{
                UIEdgeInsets inset = self.scrollView.contentInset;
                inset.top += kARRefreshContrlH;
                self.scrollView.contentInset = inset;
            }];
            [self sendActionsForControlEvents:(UIControlEventValueChanged)];
            break;
        }
    }
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setupUI];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI{
    //添加控件
    [self addSubview:self.loadImage];
    self.istabelViewBack = true;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    //图片大小  64 * 46
    CGFloat imageViewW = 64 * (46 / kARRefreshContrlH);
    CGFloat imageViewH = 46 * (46 / kARRefreshContrlH);
    self.loadImage.frame = CGRectMake(0, 0, imageViewW * 0.85, imageViewH * 0.85);
    self.loadImage.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
}


#pragma mark - 控件的懒加载
//加载动画
- (UIImageView *)loadImage {
    if (!_loadImage) {
        _loadImage = [[UIImageView alloc] init];
        _loadImage.contentMode = UIViewContentModeScaleToFill;
        _loadImage.image = [UIImage imageNamed:@"loading0"];
    }
    return _loadImage;
}
@end
