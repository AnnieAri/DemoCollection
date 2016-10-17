//
//  VoiceRecordView.m
//  Demo
//
//  Created by Ari on 16/10/16.
//  Copyright © 2016年 com.Ari. All rights reserved.
//

#import "VoiceRecordView.h"

@interface VoiceRecordView ()
@property (nonatomic,weak) UILabel *statusLabel;
@end

@implementation VoiceRecordView
- (void)setIsBtnPress:(BOOL)isBtnPress {
    _isBtnPress = isBtnPress;
    if (_isBtnPress) {
        self.statusLabel.text = @"手指上滑,取消发送";
        self.statusLabel.textColor = [UIColor whiteColor];
        
    }else {
        self.statusLabel.text = @"松开手指,取消发送";
        self.statusLabel.textColor = [UIColor whiteColor];
    }
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
    
    self.backgroundColor = [UIColor clearColor];
    
    UIView *maskView = [[UIView alloc] initWithFrame:self.bounds];
    maskView.backgroundColor = [UIColor blackColor];
    maskView.layer.cornerRadius = 8;
    maskView.layer.masksToBounds = true;
    maskView.alpha = .8;
    [self addSubview:maskView];
    UILabel *statusLabel = [[UILabel alloc] initWithFrame:self.bounds];
    self.statusLabel = statusLabel;
    statusLabel.textAlignment = NSTextAlignmentCenter;
    statusLabel.text = @"手指上滑,取消发送";
    statusLabel.textColor = [UIColor whiteColor];
    [self addSubview:statusLabel];
    
    
}
@end
