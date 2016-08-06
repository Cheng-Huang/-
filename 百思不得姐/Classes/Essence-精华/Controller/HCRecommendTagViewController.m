//
//  HCRecommendTagViewController.m
//  百思不得姐
//
//  Created by 成 黄 on 16/8/5.
//  Copyright © 2016年 成 黄. All rights reserved.
//

#import "HCRecommendTagViewController.h"
#import "HCRecommendTagCell.h"
#import <AFNetworking.h>
#import "HCRecommendTag.h"
#import <MJExtension.h>
#import <MJRefresh.h>

@interface HCRecommendTagViewController ()
/** 模型数组 */
@property (strong, nonatomic) NSMutableArray *tags;
@end

@implementation HCRecommendTagViewController

static NSString * const tagID = @"tag";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self refresh];
}

/**
 * 初始化tableView
 */
- (void)setupTableView {
    self.title = @"推荐标签";
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HCRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:tagID];
    self.tableView.rowHeight = 70;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = HCGlobalBg;
    
    // 下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
}

/**
 * 下拉刷新
 */
- (void)refresh {
    [self.tags removeAllObjects];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        HCLog(@"success-------%@", responseObject);
        [self.tableView.mj_header endRefreshing];
        self.tags = [HCRecommendTag mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        HCLog(@"error-------%@", error);
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tags.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HCRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:tagID forIndexPath:indexPath];
    cell.recommendTag = self.tags[indexPath.row];
    return cell;
}


@end
