//
//  UIButton+Addition.h
//  YOHOMars
//
//  Created by More Mocha on 16/9/23.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Addition)

+ (instancetype)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor image:(NSString *)imageName backgroundColor:(UIColor *)backgroundColor target:(id)target action:(SEL)action font:(CGFloat)font;

@end
