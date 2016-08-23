//
//  HCTabBar.m
//  百思不得姐
//
//  Created by 成 黄 on 16/7/31.
//  Copyright © 2016年 成 黄. All rights reserved.
//

#import "HCTabBar.h"
#import "HCPublishViewController.h"

@interface HCTabBar()

/** 发布按钮 */
@property (strong, nonatomic) UIButton *publishButton;

@end

@implementation HCTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 设置tabBar背景图片
        self.backgroundImage = [UIImage imageNamed:@"tabbar-light"];
        // 添加发布按钮
        self.publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [self.publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
        [self.publishButton addTarget:self action:@selector(publishBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.publishButton];
    }
    return self;
}

/**
 * 点击中间加号按钮
 */
- (void)publishBtnClicked {
    HCPublishViewController * publishVC = [[HCPublishViewController alloc] init];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:publishVC animated:NO completion:nil];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 设置发布按钮的frame
    self.publishButton.bounds = CGRectMake(0, 0, self.publishButton.currentBackgroundImage.size.width, self.publishButton.currentBackgroundImage.size.height);
    self.publishButton.center = CGPointMake(self.width * 0.5, self.height * 0.5);
    
    // 设置其他UITabBarButton的frame
    CGFloat buttonY = 0;
    CGFloat buttonW = self.width / 5;
    CGFloat buttonH = self.height;
    NSInteger index = 0;
    for (UIView *button in self.subviews) {
        if (![button isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        CGFloat buttonX = buttonW * ((index > 1) ? (index + 1) : index);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        index++;
    }
}

@end
