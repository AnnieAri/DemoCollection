//
//  ARRefreshControl.h
//  ARRefreshDemo
//
//  Created by Ari on 16/9/25.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, ARRefresgType) {
    ARRefresgTypeNormal,
    ARRefresgTypePulling,
    ARRefresgTypeRefreshing
};
@interface ARRefreshControl : UIControl
/**加载完数据 结束刷新的方法*/
- (void)endRefreshing;
/**注销快kvo*/
- (void)removeObserver;
@end
