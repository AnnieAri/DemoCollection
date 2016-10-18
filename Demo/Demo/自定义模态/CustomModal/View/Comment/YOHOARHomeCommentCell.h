//
//  YOHOARHomeCommentCell.h
//  YOHOMars
//
//  Created by Ari on 16/9/24.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YOHOARHomeCommentModel.h"
@interface YOHOARHomeCommentCell : UITableViewCell
/**评论模型*/
@property (nonatomic,strong) YOHOARHomeCommentModel *model;
/**计算行高*/
- (CGFloat)caculCellRowHeightWithModel:(YOHOARHomeCommentModel *)model;
@property (nonatomic,assign) BOOL isAriControl;
@property (nonatomic,assign) BOOL isDHControl;
@end
