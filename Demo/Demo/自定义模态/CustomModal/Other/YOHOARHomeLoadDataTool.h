//
//  YOHOARHomeLoadDataTool.h
//  YOHOMars
//
//  Created by Ari on 16/9/23.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YOHOARHomeLoadDataTool : NSObject
@property (nonatomic,strong) NSArray *homeBusinessDatas;
@property (nonatomic,strong) NSArray *homeCommentDatas;
/**加载首页数据的方法*/
- (void)loadHomeCommentsDataCompletion:(void (^)(BOOL))completion;
- (void)clearData;
@end
