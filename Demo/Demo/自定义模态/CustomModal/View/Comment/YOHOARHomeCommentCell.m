//
//  YOHOARHomeCommentCell.m
//  YOHOMars
//
//  Created by Ari on 16/9/24.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "YOHOARHomeCommentCell.h"
#import "YOHOARHomeCommentToolView.h"
#import "YOHOARHomeCommentPicView.h"
@interface YOHOARHomeCommentCell ()
/**头像*/
@property (nonatomic,weak) UIImageView *headerImageView;
/**昵称*/
@property (nonatomic,weak) UILabel *nameLabel;
/**星级评价*/
@property (nonatomic,weak) UIImageView *rankImageView;
/**评论描述*/
@property (nonatomic,weak) UILabel *describeLabel;
/**时间lable*/
@property (nonatomic,weak) UILabel *timeLabel;
/**toolBar*/
@property (nonatomic,weak) YOHOARHomeCommentToolView *toolBar;
/**评论图片的view*/
@property (nonatomic,weak) YOHOARHomeCommentPicView *picView;
/**底部背景*/
@property (nonatomic,weak) UIImageView *backGroundImageView;
/**线*/
@property (nonatomic,weak) UIImageView *lineImageView;
/**时钟*/
@property (nonatomic,weak) UIImageView *timeImageView;
@end
@implementation YOHOARHomeCommentCell

- (void)setModel:(YOHOARHomeCommentModel *)model {
    _model = model;
    [self.headerImageView yoho_useCacheImagesetImageWithUrlString:model.user.headpic placeholderImageName:@"moren_head_85x85_"];
    self.nameLabel.text = model.user.nickname;
    self.timeLabel.text = model.publish_time_str;
    //内容
    self.describeLabel.text = model.desc;
    self.describeLabel.adjustsFontSizeToFitWidth = true;
    /**星级评价*/
    NSString * str =[NSString stringWithFormat:@"score_%zd_95x11_",[model.score integerValue]];
    self.rankImageView.image = [UIImage imageNamed:str];
    CGFloat descX = self.nameLabel.viewX;
    CGFloat descY = self.rankImageView.viewY + self.rankImageView.viewHeight + 15;
    self.describeLabel.frame = CGRectMake(descX, descY, 0.8 * kScreenWidth - 10, 750);
    [self.describeLabel sizeToFit];
//    CGFloat descH =  self.describeLabel.numberOfLines * self.detailTextLabel.font.lineHeight;
    //评论图片个数
    CGSize size = [self caculPicViewSizeWithImgCount:model.img.count];
    self.describeLabel.frame = CGRectMake(68, 75,self.describeLabel.viewWidth,self.describeLabel.viewHeight);
    self.picView.frame = CGRectMake(self.describeLabel.frame.origin.x, CGRectGetMaxY(self.describeLabel.frame) + 10, size.width, size.height);
    self.picView.model = model;
    // toolBar
    [self.toolBar.iconView sd_setImageWithURL:[NSURL URLWithString:model.store.icon] placeholderImage:[UIImage imageNamed:@"area_icon_24x20_"]];
    self.toolBar.frame = CGRectMake(CGRectGetMaxX(self.headerImageView.frame), CGRectGetMaxY(self.picView.frame) + 10, 0.8 * kScreenWidth + 20, 40);
    
    //背景
    CGFloat bgHeight = CGRectGetMaxY(self.toolBar.frame);
    self.backGroundImageView.frame = CGRectMake(CGRectGetMaxX(self.headerImageView.frame), self.headerImageView.frame.origin.y, 0.8 * kScreenWidth + 20, bgHeight);
    //评论
    self.toolBar.model = model;
    //线的frame
    self.lineImageView.frame = CGRectMake(self.headerImageView.viewWidth/2.0 + self.headerImageView.viewX -1.5, CGRectGetMaxY(self.headerImageView.frame), 3, self.backGroundImageView.viewHeight - self.headerImageView.viewHeight);
    self.toolBar.isAriControl = self.isAriControl;
    self.toolBar.isDHControl = self.isDHControl;
}
- (void)awakeFromNib{
    [super awakeFromNib];
    [self setupUI];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.layer.drawsAsynchronously = true;
        self.layer.shouldRasterize = true;
        self.layer.rasterizationScale = [UIScreen mainScreen].scale;
        [self setupUI];
    }
    return self;
}
- (void)setupUI{
    self.backgroundColor = [UIColor clearColor];
    /**用户信息点击的事件   - 头像 - 昵称*/
    UITapGestureRecognizer *tagGes1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userInfoClick:)];
    /**用户信息点击的事件   - 头像 - 昵称*/
    UITapGestureRecognizer *tagGes2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userInfoClick:)];

    // 背景
    UIImageView *backGroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_315x127_"]];
    self.backGroundImageView = backGroundImageView;
    [self.contentView addSubview:backGroundImageView];
    
    // 头像
    UIImageView *headerImageView = [[UIImageView alloc] init];
    headerImageView.layer.cornerRadius = 19;
    headerImageView.layer.masksToBounds = true;
    headerImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    headerImageView.layer.borderWidth = 2;
    [self.contentView addSubview:headerImageView];
    self.headerImageView = headerImageView;
    //头像添加点击事件
    headerImageView.userInteractionEnabled = true;
    [headerImageView addGestureRecognizer:tagGes1];

    
    // 昵称
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = [UIFont boldSystemFontOfSize:17];
    nameLabel.text = @"Ari";
    [self.contentView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    nameLabel.userInteractionEnabled = true;
    [nameLabel addGestureRecognizer:tagGes2];
    
    // 星际评价
    UIImageView *rankImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"score_0_95x11_"]];
    [self.contentView addSubview:rankImageView];
    self.rankImageView = rankImageView;
    
    // 描述
    UILabel *describeLabel = [[UILabel alloc] init];
    describeLabel.numberOfLines = 0;
    describeLabel.font = [UIFont fontWithName:@"华文楷体" size:15];
//    describeLabel.preferredMaxLayoutWidth = 0.7 * yoho_screenWidth;
    [self.contentView addSubview:describeLabel];
    self.describeLabel = describeLabel;
    
    // 时间
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.textColor = [UIColor lightGrayColor];
    timeLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    // 时钟
    UIImageView *timeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"time_9x9_"]];
    self.timeImageView = timeImageView;
    [self.contentView addSubview:timeImageView];
    
    //评论图片
    YOHOARHomeCommentPicView *picView = [[YOHOARHomeCommentPicView alloc] initWithFrame:(CGRectZero) collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    self.picView = picView;
    picView.isAriControl = true;
    [self.contentView addSubview:picView];
    
//    // toolBar
    YOHOARHomeCommentToolView *toolBar = [YOHOARHomeCommentToolView homeCommentToolView];
   
    [self.contentView addSubview:toolBar];
    self.toolBar = toolBar;
//
    // 线
    UIImageView *lineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line_short_2x131_"]];
    self.lineImageView = lineImageView;
    [self addSubview:lineImageView];
//
    //计算frame
    CGFloat headerImageViewX = 10;
    CGFloat headerImageViewY = 18;
    CGFloat headerImageViewWH = 38;
    headerImageView.frame = CGRectMake(headerImageViewX, headerImageViewY, headerImageViewWH, headerImageViewWH);
    
    CGFloat nameLabelX = headerImageView.viewX + headerImageView.viewWidth + 30;
    CGFloat nameLabelY = headerImageViewY + 13;
    CGFloat namelabelH = nameLabel.font.lineHeight;
    CGFloat namelabelW = 180;
    nameLabel.frame = CGRectMake(nameLabelX, nameLabelY, namelabelW, namelabelH);
    
    CGFloat rankImageViewX = nameLabelX;
    CGFloat rankImageViewY = nameLabelY + namelabelH + 5;
    CGFloat rankImageViewW = 95;
    CGFloat rankImageViewH = 11.5;
    rankImageView.frame = CGRectMake(rankImageViewX, rankImageViewY, rankImageViewW, rankImageViewH);
    
    CGFloat timeLabelW = 80;
    CGFloat timeLabelH = timeLabel.font.lineHeight;
    CGFloat timeLabelY = nameLabelY;
    CGFloat timeLabelX = kScreenWidth - timeLabelW - 10;
    timeLabel.frame = CGRectMake(timeLabelX, timeLabelY, timeLabelW, timeLabelH);
    
    CGRect timeImageViewFrame = timeImageView.frame;
    timeImageViewFrame.origin.x = timeLabelX - timeImageViewFrame.size.width;
    timeImageView.frame = timeImageViewFrame;
    CGPoint timeImageViewCenter = timeImageView.center;
    timeImageViewCenter.y = timeLabel.center.y ;
    timeImageView.center = timeImageViewCenter;
    
    
    
}
- (CGFloat)caculCellRowHeightWithModel:(YOHOARHomeCommentModel *)model {
    [self setupUI];
    self.model = model;
//    [self layoutIfNeeded];
    return CGRectGetMaxY(self.backGroundImageView.frame);
}
- (CGSize)caculPicViewSizeWithImgCount:(NSInteger)count {
    CGFloat side;
    if (count == 0) {
        side = 1;
    }else if (count == 1){
        side = kScreenWidth *0.7;
    }else if (count == 2){
        side = kScreenWidth *0.3;
        return CGSizeMake(side * 2, side);
    }else if (count == 4){
        side = kScreenWidth *0.7;
    }else {
        NSInteger i = ((count - 1) / 3) + 1;
//        NSLog(@"count = %zd, i = %zd",count,i);
        side = ((kScreenWidth *0.7)/3 )*i;
        return CGSizeMake(kScreenWidth *0.7 , side);
    }
    return CGSizeMake(side, side);
        
}
/**头像或者昵称点击事件*/
- (void)userInfoClick:(id)sender {
    NSLog(@"头像或者昵称点击了");
    [yoho_NotificationCenter postNotificationName:yoho_ARUserInfoClickNotification object:nil userInfo:@{yoho_ARCommentModelKey : self.model}];
}
@end
