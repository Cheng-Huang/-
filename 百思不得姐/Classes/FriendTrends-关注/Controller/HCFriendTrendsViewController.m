//
//  HCFriendTrendsViewController.m
//  百思不得姐
//
//  Created by 成 黄 on 16/7/31.
//  Copyright © 2016年 成 黄. All rights reserved.
//

#import "HCFriendTrendsViewController.h"

@interface HCFriendTrendsViewController ()

@end

@implementation HCFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏题目
    self.navigationItem.title = @"我的关注";
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimage:(NSString *)@"friendsRecommentIcon" highLightedImage:(NSString *)@"friendsRecommentIcon-click" target:self action:@selector(friendsClick)];
    
    // 设置背景色
    self.view.backgroundColor = HCGlobalBg;
}

- (void)friendsClick {
    HCLogFunc;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = HCRGBColor(200, 100, 50);
    [self.navigationController pushViewController:vc animated:YES];
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
