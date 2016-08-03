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

@interface HCRecommendViewController () <UITableViewDelegate, UITableViewDataSource>
/** 类别模型数组 */
@property (strong, nonatomic) NSArray *categories;
/** 用户模型数组 */
@property (strong, nonatomic) NSArray *users;
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property (weak, nonatomic) IBOutlet UITableView *userTableView;

@end

@implementation HCRecommendViewController

static NSString * const categoryID = @"category";
static NSString * const userID = @"user";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化tableView
    [self setUpTableView];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        HCLog(@"success----%@", responseObject);
        self.categories = [HCRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.categoryTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        HCLog(@"failure----%@", error);
    }];
}

/**
 * 初始化tableView
 */
- (void)setUpTableView {
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


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.categoryTableView) {
        return self.categories.count;
    } else {
        return self.users.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.categoryTableView) {
        HCRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:categoryID];
        cell.category = self.categories[indexPath.row];
        return cell;
    } else {
        HCRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:userID];
        cell.user = self.users[indexPath.row];
        return cell;
    }
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HCRecommendCategory *category = self.categories[indexPath.row];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(category.id);
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        HCLog(@"success----%@", responseObject);
        self.users = [HCRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.userTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        HCLog(@"failure----%@", error);
    }];
}
@end
