//
//  UIImage+loadImage.m
//  ARRefreshDemo
//
//  Created by Ari on 16/10/6.
//  Copyright © 2016年 com.Ari. All rights reserved.
//

#import "UIImage+loadImage.h"

@implementation UIImage (loadImage)
/**加载动画*/
+ (UIImage *)ari_loadImage {
    NSMutableArray *images = [NSMutableArray array];
    for (int i = 0; i < 22; i++) {
        NSString *name = [NSString stringWithFormat:@"loading%d",i];
        UIImage *image = [UIImage imageNamed:name];
        [images addObject:image];
    }
    return [UIImage animatedImageWithImages:images.copy duration:22.0/12];
}
@end
