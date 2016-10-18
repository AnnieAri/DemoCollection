//
//  UIImageView+YOHOUseCacheImage.m
//  YOHOMars
//
//  Created by Ari on 16/9/24.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "UIImageView+YOHOUseCacheImage.h"

@implementation UIImageView (YOHOUseCacheImage)
- (void)yoho_useCacheImagesetImageWithUrlString:(NSString *)urlString placeholderImageName :(NSString *)imgName {
    UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:urlString];
    if (image) {
        self.image = [image scaleToWidth:self.bounds.size.width];
    }else{
        [self sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:imgName]];
    }

}
@end
