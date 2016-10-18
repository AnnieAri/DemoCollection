//
//  UIImageView+YOHOUseCacheImage.h
//  YOHOMars
//
//  Created by Ari on 16/9/24.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (YOHOUseCacheImage)
- (void)yoho_useCacheImagesetImageWithUrlString:(NSString *)urlString placeholderImageName:(NSString *)imgName;

@end
