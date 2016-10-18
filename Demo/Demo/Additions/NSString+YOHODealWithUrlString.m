//
//  NSString+YOHODealWithUrlString.m
//  YOHOMars
//
//  Created by Ari on 16/9/24.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "NSString+YOHODealWithUrlString.h"

@implementation NSString (YOHODealWithUrlString)
/**处理url的字符串*/
- (NSString *)DealWithUrlString {
    return [self stringByReplacingOccurrencesOfString:@"?imageView/{mode}/w/{width}/h/{height}" withString:@""];
}
@end
