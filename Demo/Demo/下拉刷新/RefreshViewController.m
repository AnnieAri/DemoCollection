//
//  RefreshViewController.m
//  Demo
//
//  Created by Ari on 16/10/17.
//  Copyright © 2016年 com.Ari. All rights reserved.
//

#import "RefreshViewController.h"
#import "ARRefreshControl.h"
@interface RefreshViewController ()
@property (nonatomic,weak) ARRefreshControl *arRefreshControl;
@property (nonatomic,copy) NSString *cellShowString;
@end

@implementation RefreshViewController
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.arRefreshControl removeObserver];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"refreshDemo";
    self.cellShowString = @"原始数据";
    self.tableView.backgroundColor = [UIColor darkGrayColor];
    ARRefreshControl *refreshControl = [[ARRefreshControl alloc] init];
    refreshControl.frame = CGRectMake(0, -44, self.tableView.bounds.size.width, 44);
    self.arRefreshControl = refreshControl;
    [self.tableView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(refresh) forControlEvents:(UIControlEventValueChanged)];
}
- (void)refresh {
    static NSInteger times = 0;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.cellShowString = [NSString stringWithFormat:@"刷新数据%zd",times];
        [self.tableView reloadData];
        [self.arRefreshControl endRefreshing];
        times++;
    });
}
#pragma mark - 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellid = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid];
    }
    cell.textLabel.text = self.cellShowString;
    return cell;
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"xxxx");
}
- (void)dealloc {
    NSLog(@"释放了");
}
@end
