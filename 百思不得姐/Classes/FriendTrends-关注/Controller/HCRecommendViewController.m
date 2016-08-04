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
/** AFHTTPSessionManager */
@property (strong, nonatomic) AFHTTPSessionManager *manager;
/** 请求参数 */
@property (strong, nonatomic) NSMutableDictionary *params;

@end

@implementation HCRecommendViewController

static NSString * const categoryID = @"category";
static NSString * const userID = @"user";

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化tableView
    [self setupTableView];
    
    // 添加刷新控件
    [self setupRefresh];
    
    // 加载左侧的类别数据
    [self loadCategories];
}

/**
 * 加载左侧的类别数据
 */
- (void)loadCategories {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        HCLog(@"success----%@", responseObject);
        self.categories = [HCRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.categoryTableView reloadData];
        
        // 默认选中首行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
        // 让用户表格进入下拉刷新状态
        [self.userTableView.mj_header beginRefreshing];
        
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
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    self.userTableView.mj_footer.hidden = YES;
}

/**
 * 加载用户数据
 */
- (void)loadNewUsers {
    HCRecommendCategory *category = HCSelectedCategory;
    // 设置当前页为1
    category.currentPage = 1;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(category.id);
    params[@"page"] = @(category.currentPage);
    self.params = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        HCLog(@"success----%@", responseObject);
        
        // 字典数组 -> 模型数组
        NSArray *users = [HCRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 清除旧数据
        [category.users removeAllObjects];
        
        // 给当前选中category的users数组添加当前页user模型数据
        [category.users addObjectsFromArray:users];
        
        // 保存用户总数
        category.total = [responseObject[@"total"] integerValue];
        
        HCLog(@"total = %zd", category.total);
        
        // 不是最后一次请求
        if (self.params != params) return;
        
        // 刷新右边的表格
        [self.userTableView reloadData];

        // 结束刷新
        [self.userTableView.mj_header endRefreshing];
        
        // 让底部控件结束刷新
        [self checkFooterState];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        HCLog(@"failure----%@", error);
        
        // 结束刷新
        [self.userTableView.mj_header endRefreshing];
    }];

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
    self.params = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        HCLog(@"success----%@", responseObject);
        
        // 字典数组 -> 模型数组
        NSArray *users = [HCRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 给当前选中category的users数组后添加下一页user模型数据
        [category.users addObjectsFromArray:users];
        
        // 不是最后一次请求
        if (self.params != params) return;
        
        // 刷新右边的表格
        [self.userTableView reloadData];
        
        // 让底部控件结束刷新
        [self checkFooterState];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        HCLog(@"failure----%@", error);
        
        // 让底部控件结束刷新
        [self.userTableView.mj_footer endRefreshing];
    }];
}

/**
 * 监测footer的状态
 */
- (void)checkFooterState {
    // 获取当前选中的category
    HCRecommendCategory *category = HCSelectedCategory;
    
    // 当users.count为0时不显示footer
    self.userTableView.mj_footer.hidden = (category.users.count == 0);
    
    // 让底部控件结束刷新
    if (category.users.count == category.total) {
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    } else {
        [self.userTableView.mj_footer endRefreshing];
    }
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.categoryTableView) {
        return self.categories.count;
    } else {
        // 由于右侧tableview的复用，每次加载新category下的user列表都要判断footer状态
        [self checkFooterState];
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
        
        // 获取用户loadNewUsers
        [self.userTableView.mj_header beginRefreshing];
    }
}

- (void)dealloc {
    [self.manager.operationQueue cancelAllOperations];
}
@end
