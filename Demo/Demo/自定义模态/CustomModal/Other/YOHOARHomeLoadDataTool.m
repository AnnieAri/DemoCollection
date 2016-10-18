//
//  YOHOARHomeLoadDataTool.m
//  YOHOMars
//
//  Created by Ari on 16/9/23.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "YOHOARHomeLoadDataTool.h"
#import "YOHOARHomeBusinessStoreModel.h"
#import "YOHOARHomeBusinessDistrictModel.h"
#import "YOHOARHomeCommentModel.h"
#import "YOHOARHomeCommentCell.h"

@interface YOHOARHomeLoadDataTool ()
@end
@implementation YOHOARHomeLoadDataTool
- (void)clearData {
    self.homeBusinessDatas = nil;
    self.homeBusinessDatas = nil;
}
/**加载首页评论的数据*/
- (void)loadHomeCommentsDataCompletion:(void (^)(BOOL))completion {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"comments.plist" ofType:nil];
        NSArray *list = [NSArray arrayWithContentsOfFile:path];
        self.homeCommentDatas = [NSArray yy_modelArrayWithClass:[YOHOARHomeCommentModel class] json:list];
        YOHOARHomeCommentCell *cell = [[YOHOARHomeCommentCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:nil];
        for (YOHOARHomeCommentModel *model in self.homeCommentDatas) {
            model.rowHeight = [cell caculCellRowHeightWithModel:model];
        }
        completion(true);

}



@end
