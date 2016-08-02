//
//  HCRecommendViewController.m
//  百思不得姐
//
//  Created by 成 黄 on 16/8/2.
//  Copyright © 2016年 成 黄. All rights reserved.
//

#import "HCRecommendViewController.h"
#import <AFNetworking.h>

@interface HCRecommendViewController ()

@end

@implementation HCRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"推荐关注";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        HCLog(@"progress----%@", downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        HCLog(@"success----%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        HCLog(@"failure----%@", error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
