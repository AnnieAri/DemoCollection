//
//  YOHOARHomeCommentModel.h
//  YOHOMars
//
//  Created by Ari on 16/9/24.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YOHOARHomeBusinessStoreModel.h"

/**用户信息模型*/
@interface YOHOARHomeUserModel : NSObject
/**uid*/
@property (nonatomic,copy) NSString *uid;
/**昵称*/
@property (nonatomic,copy) NSString *nickname;
/**头像图片*/
@property (nonatomic,copy) NSString *headpic;
/**b标识*/
@property (nonatomic,copy) NSString *identify;
@end
/**评论内容*/
@interface YOHOARHomeCommentDesModel : NSObject
/**评论id*/
@property (nonatomic,copy) NSString *id
/**内容*/;
@property (nonatomic,copy) NSString *content;
/**创建时间*/
@property (nonatomic,copy) NSString *create_time_str;
/**发表人*/
@property (nonatomic,strong) YOHOARHomeUserModel *user;

@end
/**评论图片模型*/
@interface YOHOARHomeCommentPicModel : NSObject
/**图片网址*/
@property (nonatomic,copy) NSString *url;
/**内容*/
@property (nonatomic,copy) NSString *content;
/**类型*/
@property (nonatomic,copy) NSString *type;
@end
/**评论模型*/
@interface YOHOARHomeCommentModel : NSObject
/**图片配文--dh*/
@property(nonatomic,copy) NSString *title;
/**位置图片--dh*/
@property(nonatomic,copy) NSString *line_pic;
/**评论id*/
@property (nonatomic,copy) NSString *id;
/**评论描述*/
@property (nonatomic,copy) NSString *desc;
/**评价星级*/
@property (nonatomic,copy) NSString *score;
/**评论数*/
@property (nonatomic,copy) NSString *comment_num;
/**发布时间*/
@property (nonatomic,copy) NSString *publish_time_str;
/**人均消费*/
@property (nonatomic,copy) NSString *consume;
/**点赞人数*/
@property (nonatomic,copy) NSString *fav_num;
/**我们是否点了赞*/
@property (nonatomic,copy) NSString *is_choice;
/**评论的图片*/
@property (nonatomic,strong) NSArray <YOHOARHomeCommentPicModel *>*img;
/**商店uid?*/
@property (nonatomic,assign) BOOL is_store_uid;
/**卖家?*/
@property (nonatomic,assign) BOOL is_seller;
/**商铺信息*/
@property (nonatomic,strong) YOHOARHomeBusinessStoreModel *store;
/**发表人*/
@property (nonatomic,strong) YOHOARHomeUserModel *user;
/**评论*/
@property (nonatomic,strong) NSArray <YOHOARHomeCommentDesModel *>*comment;
/**缓存行高*/
@property (nonatomic,assign) CGFloat rowHeight;
@end
