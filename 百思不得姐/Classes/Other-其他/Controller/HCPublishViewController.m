//
//  HCPublishViewController.m
//  百思不得姐
//
//  Created by 成 黄 on 16/8/23.
//  Copyright © 2016年 成 黄. All rights reserved.
//

#import "HCPublishViewController.h"

@interface HCPublishViewController ()

@end

@implementation HCPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 添加标语
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    sloganView.y = HCScreenH * 0.2;
    sloganView.centerX = HCScreenW * 0.5;
    [self.view addSubview:sloganView];
}

@end
