//
//  HCEssenceViewController.m
//  百思不得姐
//
//  Created by 成 黄 on 16/7/31.
//  Copyright © 2016年 成 黄. All rights reserved.
//

#import "HCEssenceViewController.h"
#import "HCRecommendTagViewController.h"
#import "HCPushGuideView.h"

@interface HCEssenceViewController ()

@end

@implementation HCEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 显示推送引导页
    [HCPushGuideView show];

    // 设置导航栏题目
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimage:(NSString *)@"MainTagSubIcon" highLightedImage:(NSString *)@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    // 设置背景色
    self.view.backgroundColor = HCGlobalBg;
}

- (void)tagClick {
    HCRecommendTagViewController *tagVC = [[HCRecommendTagViewController alloc] init];
    [self.navigationController pushViewController:tagVC animated:YES];
}

@end
