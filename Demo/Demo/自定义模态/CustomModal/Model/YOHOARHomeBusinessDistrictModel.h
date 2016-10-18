//
//  YOHOARHomeBusinessDistrictModel.h
//  YOHOMars
//
//  Created by Ari on 16/9/23.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YOHOARHomeBusinessStoreModel;
@interface YOHOARHomeBusinessDistrictModel : NSObject
/**id*/
@property (nonatomic,copy) NSString *id;
/**地名*/
@property (nonatomic,copy) NSString *name;
/**英文地名*/
@property (nonatomic,copy) NSString *english_name;
/**首页图片地址*/
@property (nonatomic,copy) NSString *headpic;
/**地方描述*/
@property (nonatomic,copy) NSString *desc;
/**商铺*/
@property (nonatomic,strong) NSArray<YOHOARHomeBusinessStoreModel *> *stores;
@end
