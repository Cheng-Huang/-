//
//  HCTabBarViewController.m
//  百思不得姐
//
//  Created by 成 黄 on 16/7/31.
//  Copyright © 2016年 成 黄. All rights reserved.
//

#import "HCTabBarViewController.h"
#import "HCEssenceViewController.h"
#import "HCNewViewController.h"
#import "HCFriendTrendsViewController.h"
#import "HCMeViewController.h"
#import "HCTabBar.h"

@interface HCTabBarViewController ()

@end

@implementation HCTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 设置tabBarItem文字颜色
    NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
    attrDict[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrDict[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *attrSelectedDict = [NSMutableDictionary dictionary];
    attrDict[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrDict[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    // 通过appearance统一设置tabBarItem文字颜色
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrDict forState:UIControlStateNormal];
    [item setTitleTextAttributes:attrSelectedDict forState:UIControlStateSelected];
    
    
    // 添加子视图控制器
    [self setUpChildVC:[[HCEssenceViewController alloc] init] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    [self setUpChildVC:[[HCNewViewController alloc] init] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    [self setUpChildVC:[[HCFriendTrendsViewController alloc] init] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    
    [self setUpChildVC:[[HCMeViewController alloc] init] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
    // 更换UITabBar(read-only) => 自定义HCTabBar (KVC)
    [self setValue:[[HCTabBar alloc] init] forKey:@"tabBar"];
    
    
}

/**
 *  创建tabBarViewController的子视图控制器
 *
 *  @param vc            子视图控制器
 *  @param title         tabBarItem文字
 *  @param image         tabBarItem图片
 *  @param selectedImage tabBarItem图片-Selected
 */
- (void)setUpChildVC:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    vc.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(100)/100.0 green:arc4random_uniform(100)/100.0 blue:arc4random_uniform(100)/100.0 alpha:1.0];
    [self addChildViewController:vc];
    // 包装一个导航控制器, 添加导航控制器为tabbarcontroller的子控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}


@end
