//
//  HCProgressView.m
//  百思不得姐
//
//  Created by 成 黄 on 16/8/23.
//  Copyright © 2016年 成 黄. All rights reserved.
//

#import "HCProgressView.h"

@implementation HCProgressView

- (void)awakeFromNib
{
    self.roundedCorners = 2;
    self.progressLabel.textColor = [UIColor whiteColor];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated {
    [super setProgress:progress animated:animated];
    NSString *text = [NSString stringWithFormat:@"%.0f%%", progress * 100];
    self.progressLabel.text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

@end
