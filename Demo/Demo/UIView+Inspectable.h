//
//  UIView+Inspectable.h
//  加速计
//
//  Created by Ari on 16/10/12.
//  Copyright © 2016年 com.Ari. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE
@interface  UIView (Inspectable)
/**圆角半径*/
@property (nonatomic,assign) IBInspectable CGFloat cornerRadius;
/**边框宽度*/
@property (nonatomic,assign) IBInspectable CGFloat borderWidth;
/**边框颜色*/
@property (nonatomic,strong) IBInspectable UIColor *borderColor;
@end
