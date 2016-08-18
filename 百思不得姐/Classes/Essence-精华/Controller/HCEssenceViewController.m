//
//  HCEssenceViewController.m
//  百思不得姐
//
//  Created by 成 黄 on 16/7/31.
//  Copyright © 2016年 成 黄. All rights reserved.
//

#import "HCEssenceViewController.h"
#import "HCRecommendTagViewController.h"
#import "HCTopicViewController.h"

@interface HCEssenceViewController () <UIScrollViewDelegate>
/** 标题红色指示器 */
@property (strong, nonatomic) UIView *indicatorView;
/** 首标题按钮 */
@property (strong, nonatomic) UIView *titleView;
/** 内容视图 */
@property (strong, nonatomic) UIScrollView *contentScrollView;


@end

@implementation HCEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 设置导航栏
    [self setupNav];
    
    // 初始化子控制器
    [self setupChildViewControllers];
    
    // 设置顶部的标签栏
    [self setupTitleView];
    
    // 设置内容视图
    [self setupContentScrollView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self titleClicked:self.titleView.subviews[0]];
}

/**
 * 初始化子控制器
 */
- (void)setupChildViewControllers {
    HCTopicViewController *allVC = [[HCTopicViewController alloc] init];
    allVC.title = @"全部";
    allVC.type = HCTopicTypeAll;
    [self addChildViewController:allVC];
    
    HCTopicViewController *videoVC = [[HCTopicViewController alloc] init];
    videoVC.title = @"视频";
    videoVC.type = HCTopicTypeVideo;
    [self addChildViewController:videoVC];
    
    HCTopicViewController *voiceVC = [[HCTopicViewController alloc] init];
    voiceVC.title = @"声音";
    voiceVC.type = HCTopicTypeVoice;
    [self addChildViewController:voiceVC];
    
    HCTopicViewController *pictureVC = [[HCTopicViewController alloc] init];
    pictureVC.title = @"图片";
    pictureVC.type = HCTopicTypePicture;
    [self addChildViewController:pictureVC];
    
    HCTopicViewController *wordVC = [[HCTopicViewController alloc] init];
    wordVC.title = @"段子";
    wordVC.type = HCTopicTypeWord;
    [self addChildViewController:wordVC];
}


/**
 * 设置内容视图
 */
- (void)setupContentScrollView {
    // 不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.contentScrollView = [[UIScrollView alloc] init];
    self.contentScrollView.frame = self.view.bounds;
    
    // 设置contentSize
    self.contentScrollView.contentSize = CGSizeMake(self.childViewControllers.count * self.view.width, self.contentScrollView.height);
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    
    // 设置代理
    self.contentScrollView.delegate = self;
    
    [self.view insertSubview:self.contentScrollView atIndex:0];
    
    // 添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
}

/**
 * 设置标题栏
 */
- (void)setupTitleView {
    // 添加标题栏
    self.titleView = [[UIView alloc] init];
    self.titleView.frame = CGRectMake(0, HCTitleViewY, self.view.width, HCTitleViewH);
    self.titleView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.8];
    [self.view addSubview:self.titleView];
    
    
    CGFloat index = 0;
    CGFloat titleBtnW = self.titleView.width / self.childViewControllers.count;
    CGFloat titleBtnH = self.titleView.height;
    for (UIViewController *VC in self.childViewControllers) {
        UIButton *titleBtn = [[UIButton alloc] init];
        titleBtn.frame = CGRectMake(index * titleBtnW, 0, titleBtnW, titleBtnH);
        [titleBtn setTitle:VC.title forState:UIControlStateNormal];
        [titleBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        titleBtn.tag = index;
        [titleBtn addTarget:self action:@selector(titleClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.titleView addSubview:titleBtn];
        index = index + 1;
        
    }
    // 添加选中红色指示器
    self.indicatorView = [[UIView alloc] init];
    self.indicatorView.backgroundColor = [UIColor redColor];
    self.indicatorView.height = 2;
    self.indicatorView.y = self.titleView.height - self.indicatorView.height;
    [self.titleView addSubview:self.indicatorView];
}

/**
 * 点击标题按钮
 */
- (void)titleClicked:(UIButton *)button {
    // 指示器动画
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
    // 滚动内容视图
    CGPoint offset = self.contentScrollView.contentOffset;
    offset.x = self.contentScrollView.width * button.tag;
    [self.contentScrollView setContentOffset:offset animated:YES];
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

#pragma mark - Scroll View Delegate

// 代码调用引起的滚动
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    // 计算index
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    // 添加子控制器视图
    UITableViewController *contentVC = self.childViewControllers[index];
    contentVC.view.x = scrollView.contentOffset.x;
    contentVC.view.y = 0;
    contentVC.view.height = scrollView.height;
    
    [scrollView addSubview:contentVC.view];
    
}

// 用户手势引起的滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    // 计算index
    NSInteger index = scrollView.contentOffset.x / scrollView.width;

    // 调用标签栏按钮点击函数
    [self titleClicked:self.titleView.subviews[index]];
}

@end
