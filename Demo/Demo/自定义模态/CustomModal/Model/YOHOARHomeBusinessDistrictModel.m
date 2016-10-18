//
//  YOHOARHomeBusinessDistrictModel.m
//  YOHOMars
//
//  Created by Ari on 16/9/23.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "YOHOARHomeBusinessDistrictModel.h"
#import "YOHOARHomeBusinessStoreModel.h"
@implementation YOHOARHomeBusinessDistrictModel
- (void)setHeadpic:(NSString *)headpic {
    _headpic = [headpic stringByReplacingOccurrencesOfString:@"?imageView/{mode}/w/{width}/h/{height}" withString:@""];
}
+(NSDictionary *)modelCustomPropertyMapper {
    return @{@"desc":@"description"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"stores" : [YOHOARHomeBusinessStoreModel class]};
}
@end
