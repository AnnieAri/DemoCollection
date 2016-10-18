//
//  UIView+Addition.m
//  004-小画板
//
//  Created by HaoYoson on 16/7/13.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "UIView+Addition.h"

@implementation UIView (Addition)
- (UIImage *)snapshotImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0);

    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];

    // 能够关闭之后，取结果！
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    // 一定要先关闭，再返回
    return result;
}
/**
 *  @author Ari
 *
 *  self.bounds.size
 *
 *  @return size
 */
- (CGSize)viewSize{
    return self.bounds.size;
}
/**
 *  @author Ari
 *
 *  self.bounds.origin
 *
 *  @return origin
 */
- (CGPoint)viewOrigin{
    return self.frame.origin;
}
/**
 *  @author Ari
 *
 *  self.bounds.origin.x
 *
 *  @return self.frame.origin.x
 */
- (CGFloat)viewX{
    return self.frame.origin.x;
}
/**
 *  @author Ari
 *
 *  self.bounds.origin.y
 *
 *  @return self.frame.origin.y
 */
- (CGFloat)viewY{
    return self.frame.origin.y;
}
/**
 *  @author Ari
 *
 *  self.bounds.size.width
 *
 *  @return self.bounds.size.width
 */
- (CGFloat)viewWidth{
    return self.bounds.size.width;
    
}
/**
 *  @author Ari
 *
 *  self.bounds.size.height
 *
 *  @return self.bounds.size.height
 */
- (CGFloat)viewHeight{
    return self.bounds.size.height;
}

@end
