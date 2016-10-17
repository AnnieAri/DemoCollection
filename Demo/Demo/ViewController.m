//
//  ViewController.m
//  Demo
//
//  Created by Ari on 16/10/16.
//  Copyright © 2016年 com.Ari. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong) NSArray *homeData;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Demo";
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
        self.navigationController.navigationBar.translucent = false;
        self.navigationController.navigationBar.clipsToBounds = false;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.homeData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellid = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid];
    }
    cell.textLabel.text = self.homeData[indexPath.row][@"name"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Class clz = NSClassFromString(self.homeData[indexPath.row][@"className"]);
    UIViewController *vc = [[clz alloc] init];
    vc.title = self.homeData[indexPath.row][@"name"];
    [self.navigationController pushViewController:vc animated:true];
}
#pragma mark - 懒加载
- (NSArray *)homeData {
    if (!_homeData) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"HomeData.plist" ofType:nil];
        _homeData = [NSArray arrayWithContentsOfFile:path];
    }
    return _homeData;
}

@end
