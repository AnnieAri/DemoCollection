//
//  YOHOARHomeCommentToolView.h
//  YOHOMars
//
//  Created by Ari on 16/9/24.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YOHOARHomeCommentModel.h"
@interface YOHOARHomeCommentToolView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (nonatomic,strong) YOHOARHomeCommentModel *model;
@property (nonatomic,assign) BOOL isAriControl;
@property (nonatomic,assign) BOOL isDHControl;
+(instancetype)homeCommentToolView;

@end
