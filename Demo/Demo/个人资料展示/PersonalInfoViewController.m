//
//  PersonalInfoViewController.m
//  Demo
//
//  Created by Ari on 16/10/17.
//  Copyright © 2016年 com.Ari. All rights reserved.
//

#import "PersonalInfoViewController.h"
#import "YOHOARUserHeaderView.h"
#import "YOHOMarkView.h"
#import "Addition.h"
#import "Masonry.h"
static NSString *CommentID = @"CommentID1";
@interface PersonalInfoViewController ()
@property (nonatomic,weak) UITableView *AriTableView;
@property (nonatomic,weak) UIImageView *bgImgView;
@property (nonatomic,weak) UIImageView *headPic;
@property (nonatomic,weak) UILabel *label;
@property (nonatomic,weak) YOHOARUserHeaderView *header;
@property (nonatomic,weak) UIButton *commentBtn;
@property (nonatomic,weak) UIButton *markBtn;
@property (nonatomic,strong) YOHOMarkView *markView;
@property (nonatomic,assign) BOOL isMark;
@property (nonatomic,strong) UIView *sectionHeader;
@end

@implementation PersonalInfoViewController
- (void)loadView {
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = view;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"";
    [self setupUI];
//    [self setNav];
    [self.AriTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"xxx"];
}
- (void)setNav {
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:(UIBarMetricsDefault)];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];//这个不设置  bar的底部会有一条黑线;
    self.navigationController.navigationBar.translucent = true;
    [self setNavTitleView];
}
- (void)setupUI {
    self.view.backgroundColor = [UIColor colorWithRed:78/255.0 green:118/255.0 blue:72/255.0 alpha:1];
    
    UITableView *AriTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:(UITableViewStylePlain)];
    self.AriTableView = AriTableView;
    AriTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:AriTableView];
    AriTableView.dataSource = self;
    AriTableView.delegate = self;
    AriTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    YOHOARUserHeaderView *headerView = [YOHOARUserHeaderView userHeaderView];
    headerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 250);
    headerView.NameLabel.text = @"Ari - 不爱吃西红柿";
    self.AriTableView.tableHeaderView = headerView;
    self.header = headerView;
    
    //添加背景图
    //    UIImageView *
    UIImageView *bgImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mine_bg_480x200_"]];
    self.bgImgView = bgImgView;
    bgImgView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 120);
    bgImgView.contentMode = UIViewContentModeScaleAspectFill;
    bgImgView.clipsToBounds = true;
    [self.view addSubview:bgImgView];
    //添加头像
    UIImageView *headPic = [[UIImageView alloc] init];
    //    headPic.image = [UIImage imageNamed:@"empty_90x90_"];
    self.headPic = headPic;
    [self.view addSubview:headPic];
    CGFloat headPicX = ([UIScreen mainScreen].bounds.size.width - 100) / 2;
    CGFloat headPicY = 120;
    headPic.layer.cornerRadius = 50;
    headPic.layer.masksToBounds = true;
    headPic.layer.borderColor = [UIColor whiteColor].CGColor;
    headPic.layer.borderWidth = 4;
    headPic.frame = CGRectMake(headPicX, headPicY, 100, 100);
    headPic.image = [UIImage imageNamed:@"headIcon"];
    
    [self.AriTableView addSubview:self.markView];
    self.markView.center = CGPointMake(AriTableView.center.x, AriTableView.center.y + 100);
}
- (void)setNavTitleView {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor whiteColor];
    label.text = @"Ari - 不爱吃西红柿";
    label.font = [UIFont fontWithName:@"BodoniSvtyTwoOSITCTT-Bold" size:22];
    self.label = label;
    [label sizeToFit];
    label.center = CGPointMake(self.navigationController.navigationBar.center.x, self.navigationController.navigationBar.center.y + 21);
    [self.navigationController.navigationBar addSubview:label];
    self.navigationController.navigationBar.clipsToBounds = true;
    //    label.frame = CGRectMake(0, 40, 49, 18);
    NSLog(@"%@",NSStringFromCGRect(self.navigationItem.titleView.frame));
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.isMark ? 10 : 20;
}
/**悬停组头*/
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.sectionHeader;
}
- (void)setButton:(UIButton *)btn {
    [btn setTitleColor:[UIColor darkGrayColor] forState:(UIControlStateNormal)];
    [btn setTitleColor:[UIColor colorWithRed:32/255.0 green:164/255.0 blue:0 alpha:1] forState:(UIControlStateSelected)];
    [btn setBackgroundColor:[UIColor whiteColor]];
    [btn addTarget:self action:@selector(sectionBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
}
- (void)sectionBtnClick:(UIButton *)sender {
    switch (sender.tag) {
        case 1://评价
        {
            sender.selected = true;
            self.markBtn.selected = false;
            self.isMark = false;
            self.markView.hidden = true;
            [self.AriTableView reloadData];
        }
            break;
            
        case 2://签到
        {
            sender.selected = true;
            self.commentBtn.selected = false;
            self.isMark = true;
            self.markView.hidden = false;
            [self.AriTableView reloadData];
        }
            break;
        default:
            break;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}
/**单元格*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"xxx" forIndexPath:indexPath];
    cell.backgroundColor =[UIColor clearColor];
    if (self.isMark) {
        cell.textLabel.text = @"";
    }else{
        cell.textLabel.text = [NSString stringWithFormat:@"数据详情 - %zd",indexPath.row];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
/**滚动代理方法*/
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
    CGRect bgFrame = self.bgImgView.frame;
    if (scrollView.contentOffset.y > (120 - 64) ) {
        bgFrame.size.height = 64;
    }else {
        bgFrame.size.height = 120 - scrollView.contentOffset.y;
    }
    self.bgImgView.frame = bgFrame;
    if (scrollView.contentOffset.y > -77 && self.bgImgView.contentMode != UIViewContentModeBottom) {
        self.bgImgView.contentMode = UIViewContentModeBottom;
    }else if (scrollView.contentOffset.y < -77 && self.bgImgView.contentMode != UIViewContentModeScaleAspectFill){
        self.bgImgView.contentMode = UIViewContentModeScaleAspectFill;
    }
    CGPoint center = self.headPic.center;
    center.y = 120 - scrollView.contentOffset.y;
    if (scrollView.contentOffset.y > -64) {
        YHValue consult = YHValueMake(-64, 40);
        YHValue result = YHValueMake(1, 0);
        CGFloat WH = [NSObject resultWithConsult:scrollView.contentOffset.y andResultValue:result andConsultValue:consult] ;
        if (WH <= 0) {
            WH = 0;
        }else if (WH >=1) {
            WH = 1;
        }
        CGRect rect = self.headPic.frame;
        rect.size.width = WH*100;
        rect.size.height = WH*100;
        self.headPic.layer.cornerRadius = WH*100*0.5;
        self.headPic.frame = rect;
    }
    self.headPic.center = center;
    //设置navbar上的label
    
    CGPoint cPoint = [self.header convertPoint:self.header.center toView:[UIApplication sharedApplication].keyWindow];
    NSLog(@"%@",NSStringFromCGPoint(cPoint));
    YHValue consult = YHValueMake(0, -22);
    YHValue result = YHValueMake(44, 22);
    CGFloat yOffSet = [NSObject resultWithConsult:cPoint.y andResultValue:result andConsultValue:consult];
    if (cPoint.y<-22) {
        yOffSet = 22;
    }
    self.label.center = CGPointMake(self.label.center.x, yOffSet);
    
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    self.navigationController.navigationBar.translucent = false;
//    self.navigationController.navigationBar.clipsToBounds = false;
    [self.label removeFromSuperview];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNav];
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}
#pragma mark - 懒加载
- (YOHOMarkView *)markView{
    if (!_markView) {
        _markView = [YOHOMarkView markView];
        _markView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width);
        _markView.hidden = true;
    }
    return _markView;
}
- (UIView *)sectionHeader {
    if (!_sectionHeader) {
        _sectionHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.AriTableView.viewWidth, 44)];
        UIButton *commentBtn = [[UIButton alloc] init];
        commentBtn.tag = 1;
        commentBtn.selected = true;
        UIButton *markBtn = [[UIButton alloc] init];
        markBtn.tag = 2;
        [commentBtn setTitle:@"详情" forState:(UIControlStateNormal)];
        [markBtn setTitle:@"签到" forState:(UIControlStateNormal)];
        [self setButton:commentBtn];
        [self setButton:markBtn];
        self.commentBtn = commentBtn;
        self.markBtn = markBtn;
        //添加到视图
        [_sectionHeader addSubview:markBtn];
        [_sectionHeader addSubview:commentBtn];
        [markBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.offset(0);
            make.left.equalTo(commentBtn.mas_right);
            make.width.equalTo(commentBtn);
        }];
        [commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.offset(0);
            make.right.equalTo(markBtn.mas_left);
            make.width.equalTo(markBtn);
        }];
        
    }
    return _sectionHeader;
}

@end
