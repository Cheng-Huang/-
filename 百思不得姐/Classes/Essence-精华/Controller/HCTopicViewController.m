//
//  HCTopicViewController.m
//  百思不得姐
//
//  Created by 成 黄 on 16/8/16.
//  Copyright © 2016年 成 黄. All rights reserved.
//

#import "HCTopicViewController.h"
#import "HCTopic.h"
#import "HCTopicCell.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import <MJRefresh.h>
#import <MJExtension.h>

@interface HCTopicViewController ()
/** 帖子模型数组 */
@property (strong, nonatomic) NSMutableArray *topics;
/** 当前页码 */
@property (nonatomic, assign) NSInteger page;
/** 当加载下一页数据时需要这个参数 */
@property (nonatomic, copy) NSString *maxtime;
/** 上一次的请求参数 */
@property (nonatomic, strong) NSDictionary *params;
@end

@implementation HCTopicViewController

static NSString * const HCTopicCellID = @"topic";

- (NSMutableArray *)topics
{
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self setupRefresher];
    
    [self.tableView.mj_header beginRefreshing];
}

/**
 * 设置tableview
 */
- (void)setupTableView {
    
    // 设置内边距
    CGFloat topInset = HCTitleViewH + HCTitleViewY;
    CGFloat bottomInset = self.tabBarController.tabBar.height;
    [self.tableView setContentInset:UIEdgeInsetsMake(topInset, 0, bottomInset, 0)];
    
    // 设置滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HCTopicCell class]) bundle:nil] forCellReuseIdentifier:HCTopicCellID];
}


/**
 * 设置刷新控件
 */
- (void)setupRefresher {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}


/**
 * 获得新数据
 */
- (void)refresh {
    // 结束上拉
    [self.tableView.mj_footer endRefreshing];
    
    [self.topics removeAllObjects];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"]= @"list";
    params[@"c"]= @"data";
    params[@"type"]= @(self.type);
    self.params = params;
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 是否和最新请求一致
        if (self.params != params) return;
        // 打印返回值
        HCLog(@"success-----%@",responseObject);
        // 字典 -> 模型
        self.topics = [HCTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        // 存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        // 刷新表格
        [self.tableView reloadData];
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
        // 清空页码
        self.page = 0;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params) return;
        
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
    }];
}

/**
 * 获得新数据
 */
- (void)loadMoreData {
    // 结束下拉
    [self.tableView.mj_header endRefreshing];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"]= @"list";
    params[@"c"]= @"data";
    params[@"type"]= @(self.type);
    params[@"maxtime"]= self.maxtime;
    NSInteger page = self.page + 1;
    params[@"page"] = @(page);
    self.params = params;
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        HCLog(@"success-----%@",responseObject);
        // 字典 -> 模型
        NSArray *newTopics = [HCTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:newTopics];
        // 存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        // 刷新表格
        [self.tableView reloadData];
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
        // 成功后赋值page，避免失败page值混乱
        self.page = page;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 打印返回值
        HCLog(@"failure----%@", error);
        // 是否和最新请求一致
        if (self.params != params) return;
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HCTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:HCTopicCellID];
    
    cell.topic = self.topics[indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HCTopic *topic = self.topics[indexPath.row];
    return topic.cellHeight;
}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 200;
//}

@end
