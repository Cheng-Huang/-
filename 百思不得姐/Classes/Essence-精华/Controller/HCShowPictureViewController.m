//
//  HCShowPictureViewController.m
//  百思不得姐
//
//  Created by 成 黄 on 16/8/22.
//  Copyright © 2016年 成 黄. All rights reserved.
//

#import "HCShowPictureViewController.h"
#import "HCTopic.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>

@interface HCShowPictureViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) UIImageView *imageView;
@end

@implementation HCShowPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 屏幕尺寸
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    
    // 添加图片
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backBtnClicked)]];
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
     
     // 图片尺寸
     CGFloat pictureW = screenW;
     CGFloat pictureH = pictureW * self.topic.height / self.topic.width;
     if (pictureH > screenH) { // 图片显示高度超过一个屏幕, 需要滚动查看
         imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
         self.scrollView.contentSize = CGSizeMake(0, pictureH);
     } else {
         imageView.size = CGSizeMake(pictureW, pictureH);
         imageView.centerY = screenH * 0.5;
     }
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image]];
}

- (IBAction)backBtnClicked {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveBtnClicked {
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败!"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功!"];
    }
}


@end
