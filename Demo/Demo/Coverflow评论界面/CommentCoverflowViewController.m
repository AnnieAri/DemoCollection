//
//  CommentCoverflowViewController.m
//  Demo
//
//  Created by Ari on 16/10/17.
//  Copyright © 2016年 com.Ari. All rights reserved.
//

#import "CommentCoverflowViewController.h"
#import "CoverFlowView.h"
@interface CommentCoverflowViewController ()

@end

@implementation CommentCoverflowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    CoverFlowView *coverFlowView = [[CoverFlowView alloc] initWithFrame:CGRectMake(0, 300, self.view.bounds.size.width, 180)];
    [self.view addSubview:coverFlowView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
