//
//  YOHOARHomeCommentModel.m
//  YOHOMars
//
//  Created by Ari on 16/9/24.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "YOHOARHomeCommentModel.h"

@implementation YOHOARHomeCommentModel
+(NSDictionary *)modelCustomPropertyMapper {
    return @{@"desc":@"description"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"img" : [YOHOARHomeCommentPicModel class],
             @"comment" : [YOHOARHomeCommentDesModel class]};
}
-(void)setLine_pic:(NSString *)line_pic {
    _line_pic = [line_pic DealWithUrlString];
}
@end
@implementation YOHOARHomeCommentPicModel
- (void)setUrl:(NSString *)url {
    _url = [url DealWithUrlString];
}
@end

@implementation YOHOARHomeUserModel
-(void)setHeadpic:(NSString *)headpic {
    _headpic = [headpic DealWithUrlString];
}
@end
@implementation YOHOARHomeCommentDesModel
@end
