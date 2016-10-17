//
//  AudioTool.h
//  Demo
//
//  Created by Ari on 16/10/17.
//  Copyright © 2016年 com.Ari. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AudioTool : NSObject
/** 提供类方法, 来传入文件名以及是否需要振动*/
+ (void)playWithName:(NSString *)name alert:(BOOL)alert;

/** 提供清空缓存方法*/
+ (void)clearMomery;

@end
