//
//  XMGTestViewController.m
//  01-百思不得姐
//
//  Created by xiaomage on 15/7/22.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "XMGTestViewController.h"

@interface XMGTestViewController ()

@end

@implementation XMGTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"XMGTestViewController";
    self.view.backgroundColor = [UIColor redColor];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = HCRGBColor(200, 100, 50);
    [self.navigationController pushViewController:vc animated:YES];
}

@end
