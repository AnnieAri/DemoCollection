//
//  UIView+Addition.h
//  004-小画板
//
//  Created by HaoYoson on 16/7/13.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Addition)
- (UIImage *)snapshotImage;
#pragma mark - View图形属性
- (CGSize)viewSize;
- (CGPoint)viewOrigin;
- (CGFloat)viewX;
- (CGFloat)viewY;
- (CGFloat)viewWidth;
- (CGFloat)viewHeight;
@end
