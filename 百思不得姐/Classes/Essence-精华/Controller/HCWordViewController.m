
//
//  HCWordViewController.m
//  百思不得姐
//
//  Created by 成 黄 on 16/8/11.
//  Copyright © 2016年 成 黄. All rights reserved.
//

#import "HCWordViewController.h"
#import "HCTopic.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import <MJRefresh.h>
#import <MJExtension.h>

@interface HCWordViewController ()
/** 帖子模型数组 */
@property (strong, nonatomic) NSMutableArray *topics;
/** 当前页码 */
@property (nonatomic, assign) NSInteger page;
/** 当加载下一页数据时需要这个参数 */
@property (nonatomic, copy) NSString *maxtime;
/** 上一次的请求参数 */
@property (nonatomic, strong) NSDictionary *params;

@end

@implementation HCWordViewController

- (NSMutableArray *)topics
{
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupRefresher];
    
    [self.tableView.mj_header beginRefreshing];
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
    params[@"type"]= @"29";
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
    
    self.page++;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"]= @"list";
    params[@"c"]= @"data";
    params[@"type"]= @"29";
    params[@"maxtime"]= self.maxtime;
    params[@"page"] = @(self.page);
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
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 打印返回值
        HCLog(@"failure----%@", error);
        // 是否和最新请求一致
        if (self.params != params) return;
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
        // 恢复页码
        self.page--;
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
    
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    HCTopic *topic = self.topics[indexPath.row];
    cell.textLabel.text = topic.name;
    cell.detailTextLabel.text = topic.text;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
