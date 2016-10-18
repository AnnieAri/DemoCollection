//
//  YOHOARHomeBusinessStoreModel.m
//  YOHOMars
//
//  Created by Ari on 16/9/23.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "YOHOARHomeBusinessStoreModel.h"

@implementation YOHOARHomeBusinessStoreModel
+(NSDictionary *)modelCustomPropertyMapper {
    return @{@"desc":@"description"};
}
- (void)setIcon:(NSString *)icon {
    _icon = [self replacingString:icon];
}
-(void)setHeadpic:(NSString *)headpic {
    _headpic = [self replacingString:headpic];
}
/**处理url的字符串*/
- (NSString *)replacingString:(NSString *)string {
    return [string stringByReplacingOccurrencesOfString:@"?imageView/{mode}/w/{width}/h/{height}" withString:@""];
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"pics" : [YOHOARHomeBusinessStorePicsModel class],
             @"category" : [YOHOARHomeBusinessStoreCategoryModel class]};
}
- (void)setOpening_time:(NSString *)opening_time {
    NSString *opening = @"全天";
    YOHOARHomeBusinessStoreOpeningTimeModel *model = [[YOHOARHomeBusinessStoreOpeningTimeModel alloc] init];
    NSMutableString *responseString = [NSMutableString stringWithString:opening_time];
    NSString *character = nil;
     for (int i = 0; i < responseString.length; i ++) {
        character = [responseString substringWithRange:NSMakeRange(i, 1)];
        if ([character isEqualToString:@"\\"])
             [responseString deleteCharactersInRange:NSMakeRange(i, 1)];
    }
    NSData *data = [responseString.copy dataUsingEncoding:(NSUTF8StringEncoding)];
    
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    if (dict) {
        [model setValuesForKeysWithDictionary:dict];
        if (!([model.start isEqualToString:@""] || [model.end isEqualToString:@""])) {
            opening = [NSString stringWithFormat:@"%@ ~ %@",
                       model.start,model.end];
        }
    }
    _opening_time = opening;
}
@end


@implementation YOHOARHomeBusinessStoreBizInfoModel

-(void)setHeadpic:(NSString *)headpic {
    _headpic = [self replacingString:headpic];
}
/**处理url的字符串*/
- (NSString *)replacingString:(NSString *)string {
    return [string stringByReplacingOccurrencesOfString:@"?imageView/{mode}/w/{width}/h/{height}" withString:@""];
}
@end

@implementation YOHOARHomeBusinessStorePicsModel
- (void)setUrl:(NSString *)url {
    _url = [url DealWithUrlString];
}

@end
@implementation YOHOARHomeBusinessStoreCategoryModel

@end
@implementation YOHOARHomeBusinessStoreOpeningTimeModel

@end
