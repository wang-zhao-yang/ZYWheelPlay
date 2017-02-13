//
//  RootTableViewController.m
//  ZYWheelPlay
//
//  Created by chuanglong03 on 2017/1/3.
//  Copyright © 2017年 chuanglong. All rights reserved.
//

#import "RootTableViewController.h"
#import "WheelPlayByManyImageViewVC.h"
#import "WheelPlayByThreeImageViewVC.h"
#import "WheelPlayByOneImageViewVC.h"

@interface RootTableViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *titleAry;

@end

@implementation RootTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = self.titleAry[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.row;
    switch (index) {
        case 0:
            [self enterWheelPlayByManyImageViewVC];
            break;
        case 1:
            [self enterWheelPlayByThreeImageViewVC];
            break;
        case 2:
            [self enterWheelPlayByOneImageViewVC];
            break;
    }
}

#pragma mark - 多张 ImageView
- (void)enterWheelPlayByManyImageViewVC {
    WheelPlayByManyImageViewVC *manyImageViewVC = [[WheelPlayByManyImageViewVC alloc] init];
    [self.navigationController pushViewController:manyImageViewVC animated:YES];
}

#pragma mark - 3 张 ImageView
- (void)enterWheelPlayByThreeImageViewVC {
    WheelPlayByThreeImageViewVC *threeImageViewVC = [[WheelPlayByThreeImageViewVC alloc] init];
    [self.navigationController pushViewController:threeImageViewVC animated:YES];
}

#pragma mark - 一张 ImageView
- (void)enterWheelPlayByOneImageViewVC {
    WheelPlayByOneImageViewVC *oneImageViewVC = [[WheelPlayByOneImageViewVC alloc] init];
    [self.navigationController pushViewController:oneImageViewVC animated:YES];
}

- (NSArray *)titleAry {
    if(_titleAry == nil) {
        _titleAry = [[NSArray alloc] initWithObjects:@"通过多张 ImageView 实现轮播", @"通过 3 张 ImageView 实现轮播", @"通过一张 ImageView 实现轮播", nil];
    }
    return _titleAry;
}

@end
