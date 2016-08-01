//
//  HCNewViewController.m
//  百思不得姐
//
//  Created by 成 黄 on 16/7/31.
//  Copyright © 2016年 成 黄. All rights reserved.
//

#import "HCNewViewController.h"

@interface HCNewViewController ()

@end

@implementation HCNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏题目
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimage:(NSString *)@"MainTagSubIcon" highLightedImage:(NSString *)@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    // 设置背景色
    self.view.backgroundColor = HCGlobalBg;
}

- (void)tagClick {
    HCLogFunc;
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
