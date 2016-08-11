//
//  HCEssenceViewController.m
//  百思不得姐
//
//  Created by 成 黄 on 16/7/31.
//  Copyright © 2016年 成 黄. All rights reserved.
//

#import "HCEssenceViewController.h"
#import "HCRecommendTagViewController.h"

@interface HCEssenceViewController ()
/** 标题红色指示器 */
@property (strong, nonatomic) UIView *indicatorView;

@end

@implementation HCEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNav];
    
    [self setupTitleView];
}

/**
 * 设置标题栏
 */
- (void)setupTitleView {
    // 添加标题栏
    UIView *titleView = [[UIView alloc] init];
    titleView.frame = CGRectMake(0, 64, self.view.width, 40);
    titleView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.8];
    [self.view addSubview:titleView];
    // 添加标题栏中的标题
    NSArray *titles = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    CGFloat index = 0;
    CGFloat titleBtnW = titleView.width / titles.count;
    CGFloat titleBtnH = titleView.height;
    for (NSString *title in titles) {
        UIButton *titleBtn = [[UIButton alloc] init];
        titleBtn.frame = CGRectMake(index * titleBtnW, 0, titleBtnW, titleBtnH);
        [titleBtn setTitle:title forState:UIControlStateNormal];
        [titleBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [titleBtn addTarget:self action:@selector(titleClicked:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:titleBtn];
        index = index + 1;
    }
    // 添加选中红色指示器
    self.indicatorView = [[UIView alloc] init];
    self.indicatorView.backgroundColor = [UIColor redColor];
    self.indicatorView.height = 2;
    self.indicatorView.y = titleView.height - self.indicatorView.height;
    [titleView addSubview:self.indicatorView];
}

/**
 * 点击标题按钮
 */
- (void)titleClicked:(UIButton *)button {
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
}

/**
 * 设置导航栏
 */
- (void)setupNav {
    // 设置导航栏题目
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimage:(NSString *)@"MainTagSubIcon" highLightedImage:(NSString *)@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    // 设置背景色
    self.view.backgroundColor = HCGlobalBg;

}

/**
 * 点击左上列表按钮
 */
- (void)tagClick {
    HCRecommendTagViewController *tagVC = [[HCRecommendTagViewController alloc] init];
    [self.navigationController pushViewController:tagVC animated:YES];
}

@end
