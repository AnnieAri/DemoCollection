//
//  YOHOCommentBigPicViewController.m
//  YOHOMars
//
//  Created by Ari on 16/9/25.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "YOHOCommentBigPicViewController.h"
#import "YOHOARCustomTransitionAnimator.h"
@interface YOHOCommentBigPicViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *storePicImage;
@property (weak, nonatomic) IBOutlet UILabel *storeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIImageView *scoreImageView;
@property (weak, nonatomic) IBOutlet UILabel *namelable;
@property (weak, nonatomic) IBOutlet UIButton *favBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (nonatomic,assign) BOOL isOn;
@end

@implementation YOHOCommentBigPicViewController
- (void)setBigPic:(UIImage *)bigPic {
    _bigPic = bigPic;
    self.PicView.image = bigPic;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.PicView.image = self.bigPic;
    self.toolBarView.alpha = 0;
    self.descView.alpha = 0;
    _isOn = true;
    [self setupUI];
}
- (void)setupUI {
    /**标题*/
    NSString *name = ([self.model.store.store_english_name isEqualToString:@""]) ? self.model.store.store_name : self.model.store.store_english_name;
    self.storeNameLabel.text = name;
    /**是否点赞*/
    self.favBtn.selected = [self.model.is_choice boolValue];
    /**赞数量*/
    NSString *favNumber = self.model.fav_num.integerValue == 0 ? @"" : self.model.fav_num;
    [self.favBtn setTitle:favNumber forState:(UIControlStateNormal)];
    /**评论数量*/
    NSString *commenNum = self.model.comment_num.integerValue == 0 ? @"" : self.model.comment_num;
    [self.commentBtn setTitle:commenNum forState:(UIControlStateNormal)];
    /**详细信息*/
    self.descLabel.text = self.model.desc;
    /**星级评价*/
    NSString * str =[NSString stringWithFormat:@"score_%zd_95x11_",[self.model.score integerValue]];
    self.scoreImageView.image = [UIImage imageNamed:str];
    /**作者*/
    self.namelable.text = self.model.user.nickname;
    /**商店图标*/
    [self.storePicImage sd_setImageWithURL:[NSURL URLWithString:self.model.store.icon] placeholderImage:[UIImage imageNamed:@"sutroMetal"]];
    
}
- (IBAction)backBtnClick:(UIButton *)sender {
  
    if (self.willDismiss) {
        self.willDismiss();
    }
    [self dismissViewControllerAnimated:true completion:^{
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [UIView animateWithDuration:.25 animations:^{

        self.toolBarView.alpha = !_isOn;
            self.descView.alpha = !_isOn;
    } completion:^(BOOL finished) {
        _isOn = !_isOn;
    }];
}
#pragma mark - 点击事件
- (IBAction)favBtnClick:(UIButton *)sender {
    NSLog(@"点赞按钮点击");
    self.model.fav_num = [NSString stringWithFormat:@"%zd",!self.favBtn.isSelected ? self.model.fav_num.integerValue + 1 : self.model.fav_num.integerValue - 1];
    NSLog(@"%@",self.model.fav_num);
    sender.selected = !sender.isSelected;
    self.model.is_choice =[NSString stringWithFormat:@"%zd",sender.isSelected];
    self.model = self.model;
    /**是否点赞*/
    self.favBtn.selected = [self.model.is_choice boolValue];
    /**赞数量*/
    NSString *favNumber = self.model.fav_num.integerValue == 0 ? @"" : self.model.fav_num;
    [self.favBtn setTitle:favNumber forState:(UIControlStateNormal)];
}
- (IBAction)commentBtnClick:(id)sender {
}
- (IBAction)shareBtnClick:(id)sender {
}

@end
