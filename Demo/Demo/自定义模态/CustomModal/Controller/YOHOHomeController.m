//
//  YOHOHomeController.m
//  YOHOMars
//
//  Created by 闫雨轩 on 16/9/22.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "YOHOHomeController.h"
#import "YOHOARHomeLoadDataTool.h"
#import "YOHOARHomeCommentCell.h"
#import "YOHOARCustomTransitionAnimator.h"
#import "YOHOCommentBigPicViewController.h"
#define kSectionHeaderHeight 40
static NSString *CommentID = @"CommentID";
@interface YOHOHomeController ()
/**一个加载数据的对象*/
@property (nonatomic,strong) YOHOARHomeLoadDataTool *loadDataTool;
/**做动画的对象*/
@property (nonatomic,strong) YOHOARCustomTransitionAnimator *animator;
@end

@implementation YOHOHomeController
/**初始化为group类型*/
- (instancetype)init {
    if (self = [super initWithStyle:(UITableViewStyleGrouped)]) {
        
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:NO];

}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setupUI];
    [self loadData];
    //注册通知
    [self regiserNotification];
}
- (void)regiserNotification{
    /**评论的图片点击事件*/
    [yoho_NotificationCenter addObserver:self selector:@selector(commentPicClickNotification:) name:yoho_ARCommentPicClickNotification object:nil];
    /**评论的商铺点击事件*/
    [yoho_NotificationCenter addObserver:self selector:@selector(storeNameBtnClickNotification:) name:yoho_ARstoreNameBtnClickNotification object:nil];
    /**评论按钮点击的事件*/
    [yoho_NotificationCenter addObserver:self selector:@selector(CommentBtnClick:) name:yoho_ARCommentCommentBtnClickNotification object:nil];
    /**用户点击事件*/
    [yoho_NotificationCenter addObserver:self selector:@selector(UserInfoClick:) name:yoho_ARUserInfoClickNotification object:nil];
}
/**评论的图片点击事件*/
- (void)commentPicClickNotification:(NSNotification *)not {
    // 弹出控制器
    YOHOCommentBigPicViewController* vc = [[YOHOCommentBigPicViewController alloc] init];
    UIView *cell = not.userInfo[yoho_ARCommentFrameKey];
    YOHOARHomeCommentModel *model = not.userInfo[yoho_ARCommentModelKey];
    CGRect rect = [cell convertRect:cell.bounds toView:[UIApplication sharedApplication].keyWindow];
    vc.modalPresentationStyle = UIModalPresentationCustom;
    // 创建一个专门做动画的对象
    self.animator = [[YOHOARCustomTransitionAnimator alloc] init];
    //图片赋值
    vc.bigPic = not.userInfo[yoho_ARCommentPicKey];
    vc.model = model;
    __weak typeof(self) weakSelf = self;
    //控制器内部可能做点赞的操作 , 所以要从新刷新这一行
    vc.willDismiss = ^{
        NSInteger index = [weakSelf.loadDataTool.homeCommentDatas indexOfObject:model];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
    };
    self.animator.toVCPicFrame = rect;
    // 设置转场代理
    vc.transitioningDelegate = self.animator;
    [self presentViewController:vc animated:YES completion:nil];
}
/**评论按钮点击的事件*/
- (void)CommentBtnClick:(NSNotification *)noti {
    NSLog(@"评论按钮点击了");
}
/**评论的商铺点击事件*/
- (void)storeNameBtnClickNotification:(NSNotification *)noti {
    //跳转
    NSLog(@"商铺点击了 %@",noti.userInfo);
    
}
 /**随便看看商铺点击事件*/
- (void)HomeBusinessStoresCellClickNotification:(NSNotification *)noti {
    NSLog(@"商铺点击");
}
/**用户点击事件*/
- (void)UserInfoClick:(NSNotification *)noti{
    NSLog(@"用户点击%@",noti.userInfo);
}
- (void)dealloc {
    [yoho_NotificationCenter removeObserver:self];
}
- (void)loadData{
   [self.loadDataTool loadHomeCommentsDataCompletion:^(BOOL isSuccess) {
       if (isSuccess) {
           NSLog(@"成功");
           [self.tableView reloadData];
       }else {
           NSLog(@"失败");
       }
   }];
}

#pragma mark - 布局
- (void)setupUI {
    self.tableView.backgroundColor = yohoBackGroundColour;
    //注册城市热评cell
    [self.tableView registerClass:[YOHOARHomeCommentCell class] forCellReuseIdentifier:CommentID];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
#pragma mark - 数据源代理
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        YOHOARHomeCommentModel *model = self.loadDataTool.homeCommentDatas[indexPath.row];
        return model.rowHeight;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return self.loadDataTool.homeCommentDatas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {


        YOHOARHomeCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:CommentID forIndexPath:indexPath];
        cell.isAriControl = true;
        YOHOARHomeCommentModel *model = self.loadDataTool.homeCommentDatas[indexPath.row];
        cell.model = model;
        return cell;
}


#pragma mark - 懒加载
- (YOHOARHomeLoadDataTool *)loadDataTool {
    if (!_loadDataTool) {
        _loadDataTool = [[YOHOARHomeLoadDataTool alloc] init];
    }
    return _loadDataTool;
}


@end
