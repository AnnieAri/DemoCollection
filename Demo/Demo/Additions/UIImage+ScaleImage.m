//
//  UIImage+ScaleImage.m
//  WeiBo-OC
//
//  Created by Ari on 16/9/7.
//  Copyright © 2016年 com.Ari. All rights reserved.
//

#import "UIImage+ScaleImage.h"

@implementation UIImage (ScaleImage)
- (UIImage *)scaleToWidth:(CGFloat )width{
    if (self.size.width < width) {
        return self;
    }
    CGFloat height = self.size.height * (width / self.size.width);
    CGRect rect = CGRectMake(0, 0, width * 2, height * 2);
    //开启上下文
    UIGraphicsBeginImageContext(rect.size);
    //将图片渲染到上下文中
    [self drawInRect:rect];
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    return  result;
}

- (UIImage *)imageWithColor:(UIColor *)color
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    CGContextRef context= UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextClipToMask(context, rect, self.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
@end
