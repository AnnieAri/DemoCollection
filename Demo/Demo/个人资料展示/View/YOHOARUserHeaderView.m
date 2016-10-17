//
//  YOHOARUserHeaderView.m
//  YOHOMars
//
//  Created by Ari on 16/9/26.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "YOHOARUserHeaderView.h"

@interface YOHOARUserHeaderView ()


@end
@implementation YOHOARUserHeaderView
+ (instancetype)userHeaderView {
    return [[NSBundle mainBundle] loadNibNamed:@"YOHOARUserHeaderView" owner:nil options:nil].lastObject;
}
- (void)awakeFromNib{
    [super awakeFromNib];
    [self setupUI];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI{
    
}
@end
