//
//  UIView+Inspectable.m
//  加速计
//
//  Created by Ari on 16/10/12.
//  Copyright © 2016年 com.Ari. All rights reserved.
//

#import <objc/runtime.h>
#import "UIView+Inspectable.h"

@implementation UIView (Inspectable)
/**圆角半径*/
- (void)setCornerRadius:(CGFloat)cornerRadius {
    objc_setAssociatedObject(self, @"cornerRadius", @(cornerRadius), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = cornerRadius > 0 ? true : false;
}
- (CGFloat)cornerRadius {
    return [objc_getAssociatedObject(self, @"cornerRadius") doubleValue];
}
/**边框宽度*/
- (void)setBorderWidth:(CGFloat)borderWidth {
    objc_setAssociatedObject(self, @"borderWidth", @(borderWidth), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.layer.borderWidth = borderWidth;
    
}
- (CGFloat)borderWidth {
    return [objc_getAssociatedObject(self, @"borderWidth") doubleValue];
}
/**边框颜色*/
- (void)setBorderColor:(UIColor *)borderColor {
     objc_setAssociatedObject(self, @"borderColor", borderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.layer.borderColor = borderColor.CGColor;
}
@end
