//
//  YOHOARUserHeaderView.h
//  YOHOMars
//
//  Created by Ari on 16/9/26.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YOHOARUserHeaderView : UIView
@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
+ (instancetype)userHeaderView;
@end
