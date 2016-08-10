//
//  HCPushGuideView.m
//  百思不得姐
//
//  Created by 成 黄 on 16/8/10.
//  Copyright © 2016年 成 黄. All rights reserved.
//

#import "HCPushGuideView.h"

@implementation HCPushGuideView

+ (void)show {
    NSString *key = @"CFBundleShortVersionString";
    // 判断是否是新版本
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    NSString *sandboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    if (![sandboxVersion isEqualToString:currentVersion]) {
        // 显示推送引导页
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        HCPushGuideView *pushGuideView = [HCPushGuideView guideView];
        pushGuideView.frame = window.bounds;
        [window addSubview:pushGuideView];
        // 存储新版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (instancetype)guideView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (IBAction)close:(id)sender {
    [self removeFromSuperview];
}

@end
