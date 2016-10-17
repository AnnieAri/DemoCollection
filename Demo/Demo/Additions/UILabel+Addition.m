//
//  UILabel+Addition.m
//  生活圈
//
//  Created by heima on 16/6/24.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "UILabel+Addition.h"

@implementation UILabel (Addition)

+ (instancetype)labelWithText:(NSString*)text andTextColor:(UIColor*)textColor andFontSize:(CGFloat)fontSize
{
    UILabel* label = [[self alloc] init];
    label.text = text;
    label.textColor = textColor;
    label.font = [UIFont systemFontOfSize:fontSize];
    return label;
}

@end
