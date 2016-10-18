//
//  YOHOARHomeCommentPicView.h
//  YOHOMars
//
//  Created by Ari on 16/9/24.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YOHOARHomeCommentModel.h"
@interface YOHOARHomeCommentPicView : UICollectionView
@property (nonatomic,strong) NSArray<YOHOARHomeCommentPicModel *> *pics;
@property (nonatomic,strong) YOHOARHomeCommentModel *model;
@property (nonatomic,assign) BOOL isAriControl;
@end
