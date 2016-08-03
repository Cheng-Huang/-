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

@interface HCRecommendViewController () <UITableViewDelegate, UITableViewDataSource>
/** 类别模型数组 */
@property (strong, nonatomic) NSArray *categories;
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;

@end

@implementation HCRecommendViewController

static NSString * const categoryID = @"category";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 注册
    [self.categoryTableView registerClass:[HCRecommendCategoryCell class] forCellReuseIdentifier:categoryID];
    
    self.title = @"推荐关注";
    
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
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.categories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HCRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:categoryID];
    HCRecommendCategory *category = self.categories[indexPath.row];
    cell.textLabel.text = category.name;
    return cell;
}

@end
