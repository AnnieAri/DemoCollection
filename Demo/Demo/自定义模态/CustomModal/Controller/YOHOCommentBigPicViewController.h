//
//  YOHOCommentBigPicViewController.h
//  YOHOMars
//
//  Created by Ari on 16/9/25.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YOHOARHomeCommentModel.h"
@interface YOHOCommentBigPicViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *PicView;
@property (nonatomic,strong) UIImage *bigPic;
@property (weak, nonatomic) IBOutlet UIView *toolBarView;
@property (weak, nonatomic) IBOutlet UIView *descView;
@property (nonatomic,strong) YOHOARHomeCommentModel *model;
/**将要dismiss掉了*/
@property (nonatomic,copy) void (^willDismiss)();
@end
