//
//  UIButton+Addition.m
//  YOHOMars
//
//  Created by More Mocha on 16/9/23.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "UIButton+Addition.h"

@implementation UIButton (Addition)

+ (instancetype)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor image:(NSString *)imageName backgroundColor:(UIColor *)backgroundColor target:(id)target action:(SEL)action font:(CGFloat)font {

    // 创建一个按钮
    UIButton *button = [[UIButton alloc] init];
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    
    [button sizeToFit];
    
    return button;
}

@end
