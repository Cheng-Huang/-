//
//  HCMeViewController.m
//  百思不得姐
//
//  Created by 成 黄 on 16/7/31.
//  Copyright © 2016年 成 黄. All rights reserved.
//

#import "HCMeViewController.h"

@interface HCMeViewController ()

@end

@implementation HCMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏题目
    self.navigationItem.title = @"我的";
    
    // 设置导航栏右边的按钮
    UIBarButtonItem *settingButton = [UIBarButtonItem itemWithimage:(NSString *)@"mine-setting-icon" highLightedImage:(NSString *)@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    UIBarButtonItem *nightModeButton = [UIBarButtonItem itemWithimage:(NSString *)@"mine-moon-icon" highLightedImage:(NSString *)@"mine-moon-icon-click" target:self action:@selector(nightModeClick)];
    
    self.navigationItem.rightBarButtonItems = @[settingButton, nightModeButton];
    
    // 设置背景色
    self.view.backgroundColor = HCGlobalBg;
}

- (void)settingClick {
    HCLogFunc;
}

- (void)nightModeClick {
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
