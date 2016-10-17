//
//  AudioTool.m
//  Demo
//
//  Created by Ari on 16/10/17.
//  Copyright © 2016年 com.Ari. All rights reserved.
//

#import "AudioTool.h"
#import <AVFoundation/AVFoundation.h>
@implementation AudioTool

/**
 缓存 name 以及对应的 soundID .
 基于上述的情况, 需要使用字典来缓存. Key:name  Value:soundID
 因为文件名name是相同的.我们比较的是name.
 
 1. 保证只加载一次
 2. 当传入文件名后, 需要先对缓存做判断
 3. 当SoundID创建后, 应该缓存起来
 */


//下面的方法会保证缓存字典只创建一次
static NSMutableDictionary *_cacheDict;
+ (void)initialize
{
    _cacheDict = [NSMutableDictionary dictionary];
}


/** 提供类方法, 来传入文件名以及是否需要振动*/
+ (void)playWithName:(NSString *)name alert:(BOOL)alert
{
    
    //1. 通过文件名从缓存中获取SoundID
    SystemSoundID soundID = [_cacheDict[name] intValue];
    
    NSLog(@"sound: %zd", soundID);
    
    //2. 判断soundID是否有值 --> 如果取出了一个空的值, 那么soundID肯定为0
    if (soundID == 0) {
        
        //3. 创建系统声音ID
        //3.1 创建URL
        NSString *urlStr = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:name];
        NSURL *url = [NSURL fileURLWithPath:urlStr];
        
        //3.2 将URL地址和SoundID进行绑定  --> URL = 姓名 : SoundID = 电话
        //绑定之后可以通过SoundID来找到URL地址.
        AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &soundID);
        
        //4. 缓存soundID
        _cacheDict[name] = @(soundID);
        
    }
    
    //5. 执行播放方法 --> System 不带振动
    if (alert) {
        AudioServicesPlayAlertSound(soundID);
    } else {
        AudioServicesPlaySystemSound(soundID);
    }
}


/** 提供情况缓存方法*/
+ (void)clearMomery
{
    /**
     1. 音效所占用的内存
     2. 清空字典
     */
    [_cacheDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        //1. 音效所占用的内存
        SystemSoundID soundID = [obj intValue];
        AudioServicesDisposeSystemSoundID(soundID);
        
    }];
    
    //2. 清空字典
    [_cacheDict removeAllObjects];
    
}
@end
