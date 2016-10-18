//
//  YOHOARHomeCommentToolView.m
//  YOHOMars
//
//  Created by Ari on 16/9/24.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "YOHOARHomeCommentToolView.h"

@interface YOHOARHomeCommentToolView ()
@property (weak, nonatomic) IBOutlet UIButton *storeNameBtn;
@property (weak, nonatomic) IBOutlet UIButton *favBtn;
@property (weak, nonatomic) IBOutlet UIButton *conmentBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;

@end
@implementation YOHOARHomeCommentToolView
- (void)setModel:(YOHOARHomeCommentModel *)model {
    _model = model;
    /**标题*/
    NSString *name = ([model.store.store_english_name isEqualToString:@""]) ? model.store.store_name : model.store.store_english_name;
    [self.storeNameBtn setTitle:name forState:(UIControlStateNormal)];
    /**是否点赞*/
    if ([model.is_choice boolValue]) {
        self.favBtn.selected = true;
    }else{
        self.favBtn.selected = false;
    }
    /**赞数量*/
    NSString *favNumber = model.fav_num.integerValue == 0 ? @"" : model.fav_num;
    [self.favBtn setTitle:favNumber forState:(UIControlStateNormal)];
    /**评论数量*/
    NSString *commenNum = model.comment_num.integerValue == 0 ? @"" : model.comment_num;
    [self.conmentBtn setTitle:commenNum forState:(UIControlStateNormal)];
}
+ (instancetype)homeCommentToolView {
    return [[NSBundle mainBundle] loadNibNamed:@"YOHOARHomeCommentToolView" owner:nil options:nil].lastObject;
}
- (IBAction)shareBtnClick:(id)sender {
    NSLog(@"点击了分享");
}
- (IBAction)commentBtnClick:(id)sender {
    NSLog(@"评论按钮点击");
     [yoho_NotificationCenter postNotificationName:yoho_ARCommentCommentBtnClickNotification object:nil userInfo:@{yoho_ARCommentCommentModelKey : self.model}];
}
- (IBAction)favBtnClick:(UIButton *)sender {
    NSLog(@"点赞按钮点击");
    self.model.fav_num = [NSString stringWithFormat:@"%zd",!self.favBtn.isSelected ? self.model.fav_num.integerValue + 1 : self.model.fav_num.integerValue - 1];
    NSLog(@"%@",self.model.fav_num);
    sender.selected = !sender.isSelected;
    self.model.is_choice =[NSString stringWithFormat:@"%zd",sender.isSelected];
    self.model = self.model;
    
}
- (IBAction)storeNameBtnClick:(id)sender {
    NSLog(@"商铺");
    if (self.isAriControl) {
        [yoho_NotificationCenter postNotificationName:yoho_ARstoreNameBtnClickNotification object:nil userInfo:@{yoho_ARstoreModelKey : self.model.store}];
    }
    if (self.isDHControl) {
        NSLog(@"傻逼控制器点击");
         [yoho_NotificationCenter postNotificationName:yoho_DHstoreNameBtnClickNotification object:nil userInfo:@{yoho_ARstoreModelKey : self.model.store}];
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
    self.backgroundColor = [UIColor clearColor];
}

@end
