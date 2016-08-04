//
//  HCRecommendViewController.m
//  百思不得姐
//
//  Created by 成 黄 on 16/8/2.
//  Copyright © 2016年 成 黄. All rights reserved.
//

#import "HCRecommendViewController.h"
#import <AFNetworking.h>
#import "HCRecommendCategory.h"
#import <MJExtension.h>
#import "HCRecommendCategoryCell.h"
#import "HCRecommendUser.h"
#import "HCRecommendUserCell.h"
#import <MJRefresh.h>

#define HCSelectedCategory self.categories[self.categoryTableView.indexPathForSelectedRow.row]

@interface HCRecommendViewController () <UITableViewDelegate, UITableViewDataSource>
/** 类别模型数组 */
@property (strong, nonatomic) NSArray *categories;
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property (weak, nonatomic) IBOutlet UITableView *userTableView;

@end

@implementation HCRecommendViewController

static NSString * const categoryID = @"category";
static NSString * const userID = @"user";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化tableView
    [self setupTableView];
    
    // 添加刷新控件
    [self setupRefresh];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        HCLog(@"success----%@", responseObject);
        self.categories = [HCRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.categoryTableView reloadData];
        
        // 默认选中首行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        HCLog(@"failure----%@", error);
    }];
}

/**
 * 初始化tableView
 */
- (void)setupTableView {
    // 注册
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([HCRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:categoryID];
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([HCRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:userID];
    // 设置inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
    self.userTableView.rowHeight = 70;
    
    self.title = @"推荐关注";
    
    self.view.backgroundColor = HCGlobalBg;
    self.categoryTableView.backgroundColor = [UIColor clearColor];
    self.userTableView.backgroundColor = [UIColor clearColor];
}

/**
 * 添加刷新控件
 */
- (void)setupRefresh {
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
}

/**
 * 获得下一页数据
 */
- (void)loadMoreUsers {
    HCRecommendCategory *category = HCSelectedCategory;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @([HCSelectedCategory id]);
    params[@"page"] = @(++category.currentPage);
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        HCLog(@"success----%@", responseObject);
        NSArray *users = [HCRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [category.users addObjectsFromArray:users];
        [self.userTableView reloadData];
        // 让底部控件结束刷新
        if (category.users.count == category.total) {
            [self.userTableView.mj_footer noticeNoMoreData];
        } else {
            [self.userTableView.mj_footer endRefreshing];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        HCLog(@"failure----%@", error);
        [self.userTableView.mj_footer endRefreshing];
    }];
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.categoryTableView) {
        return self.categories.count;
    } else {
        HCRecommendCategory *category = HCSelectedCategory;
        HCLog(@"users.count = %zd", category.users.count);
        return category.users.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.categoryTableView) {
        HCRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:categoryID];
        cell.category = self.categories[indexPath.row];
        return cell;
    } else {
        HCRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:userID];
        HCRecommendCategory *category = HCSelectedCategory;
        cell.user = category.users[indexPath.row];
        return cell;
    }
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HCRecommendCategory *category = self.categories[indexPath.row];
    
    if (category.users.count) {
        [self.userTableView reloadData];
    } else {
        // 避免用户点击下一个category时，看到前一个category的用户列表
        [self.userTableView reloadData];
        
        // 设置当前页为1
        category.currentPage = 1;
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"list";
        params[@"c"] = @"subscribe";
        params[@"category_id"] = @(category.id);
        params[@"page"] = @(category.currentPage);
        
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            HCLog(@"success----%@", responseObject);
            NSArray *users = [HCRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            [category.users addObjectsFromArray:users];
            
            // 保存用户总数
            category.total = [responseObject[@"total"] integerValue];
            
            HCLog(@"total = %zd", category.total);
            
            [self.userTableView reloadData];
            // 让底部控件结束刷新
            if (category.users.count == category.total) {
                [self.userTableView.mj_footer noticeNoMoreData];
            } else {
                [self.userTableView.mj_footer endRefreshing];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            HCLog(@"failure----%@", error);
        }];        
    }
    
}
@end
