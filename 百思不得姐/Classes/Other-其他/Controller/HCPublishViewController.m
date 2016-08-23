//
//  HCPublishViewController.m
//  百思不得姐
//
//  Created by 成 黄 on 16/8/23.
//  Copyright © 2016年 成 黄. All rights reserved.
//

#import "HCPublishViewController.h"
#import "HCVerticalButton.h"

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
    
    // 数据
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    // 中间的6个按钮
    int maxCols = 3;
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 40;
    CGFloat buttonStartY = (HCScreenH - 2 * buttonH) * 0.5;
    CGFloat buttonStartX = 20;
    CGFloat xMargin = (HCScreenW - 2 * buttonStartX - maxCols * buttonW) / (maxCols - 1);
    for (int i = 0; i<images.count; i++) {
        HCVerticalButton *button = [[HCVerticalButton alloc] init];
        // 设置内容
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        
        // 设置frame
        button.width = buttonW;
        button.height = buttonH;
        int row = i / maxCols;
        int col = i % maxCols;
        button.x = buttonStartX + col * (xMargin + buttonW);
        button.y = buttonStartY + row * buttonH;
        [self.view addSubview:button];
    }

}

- (IBAction)cancelBtnClicked {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
