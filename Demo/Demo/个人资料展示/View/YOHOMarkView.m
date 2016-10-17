//
//  YOHOMarkView.m
//  YOHOMars
//
//  Created by Ari on 16/9/27.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "YOHOMarkView.h"

@implementation YOHOMarkView

+ (instancetype)markView {
    return [[NSBundle mainBundle] loadNibNamed:@"YOHOMarkView" owner:nil options:nil].lastObject;
}

@end
