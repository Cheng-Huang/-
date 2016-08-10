//
//  HCLoginRegisterViewController.m
//  百思不得姐
//
//  Created by 成 黄 on 16/8/8.
//  Copyright © 2016年 成 黄. All rights reserved.
//

#import "HCLoginRegisterViewController.h"

@interface HCLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewMarginLeft;
@end

@implementation HCLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)closeBtnClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)showLoginOrRegister:(UIButton *)sender {
    
    if (self.loginViewMarginLeft.constant == 0) {
        self.loginViewMarginLeft.constant = - self.view.width;
        sender.selected = YES;
    } else {
        self.loginViewMarginLeft.constant = 0;
        sender.selected = NO;
    }
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 白色状态栏
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
