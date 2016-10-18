//
//  YOHOARHomeBusinessStoreModel.h
//  YOHOMars
//
//  Created by Ari on 16/9/23.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
/**开关店时间*/
@interface YOHOARHomeBusinessStoreOpeningTimeModel : NSObject
@property (nonatomic,copy) NSString *start;
@property (nonatomic,copy) NSString *end;
@end

@interface YOHOARHomeBusinessStoreBizInfoModel : NSObject
/**id*/
@property (nonatomic,copy) NSString *id;
/**商铺名称*/
@property (nonatomic,copy) NSString *name;
/**商铺英文名称*/
@property (nonatomic,copy) NSString *english_name;
/**大图*/
@property (nonatomic,copy) NSString *headpic;
@end
@interface YOHOARHomeBusinessStorePicsModel : NSObject
/**图片url*/
@property (nonatomic,copy) NSString *url;
/**图片宽*/
@property (nonatomic,assign) NSInteger width;
/**图片高*/
@property (nonatomic,assign) NSInteger height;
/**评论id*/
@property (nonatomic,copy) NSString *comment_id;
@end
@interface YOHOARHomeBusinessStoreCategoryModel : NSObject
/**标签id*/
@property (nonatomic,copy) NSString *tag_id;
/**标签名字(分类名字)*/
@property (nonatomic,copy) NSString *tag_name;
@end
@interface YOHOARHomeBusinessStoreModel : NSObject
/**id*/
@property (nonatomic,copy) NSString *id;
/**商铺名称*/
@property (nonatomic,copy) NSString *store_name;
/**商铺英文名称*/
@property (nonatomic,copy) NSString *store_english_name;
/**副标题*/
@property (nonatomic,copy) NSString *store_sub_title;
/**经度*/
@property (nonatomic,copy) NSString *longitude;
/**纬度*/
@property (nonatomic,copy) NSString *latitude;
/**描述*/
@property (nonatomic,copy) NSString *desc;
/**图标*/
@property (nonatomic,copy) NSString *icon;
/**大图*/
@property (nonatomic,copy) NSString *headpic;
/**星级*/
@property (nonatomic,copy) NSString *score;
/**评估用户*/
@property (nonatomic,copy) NSString *assessment_user;
/**人均消费*/
@property (nonatomic,copy) NSString *consumption;
/**开关店时间*/
@property (nonatomic,copy) NSString *opening_time;
/**城市编号*/
@property (nonatomic,copy) NSString *city;
/**地址*/
@property (nonatomic,copy) NSString *address;
/**收集基数*/
@property (nonatomic,copy) NSString *collect_base_number;
/**是不是新店*/
@property (nonatomic,assign) BOOL is_new;
/**店铺分类*/
@property (nonatomic,strong) NSArray<YOHOARHomeBusinessStoreCategoryModel *> *category;
/**商业信息*/
@property (nonatomic,strong) YOHOARHomeBusinessStoreBizInfoModel *bizinfo;
/**是否收藏*/
@property (nonatomic,assign) BOOL is_fav;
/**评论附带信息*/
@property (nonatomic,strong) NSArray <YOHOARHomeBusinessStorePicsModel *>*pics;
@end
