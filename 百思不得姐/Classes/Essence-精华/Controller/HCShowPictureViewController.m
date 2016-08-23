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
#import "HCProgressView.h"

@interface HCShowPictureViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) UIImageView *imageView;
@property (weak, nonatomic) IBOutlet HCProgressView *progressView;
@end

@implementation HCShowPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加图片
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backBtnClicked)]];
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
     
     // 图片尺寸
     CGFloat pictureW = HCScreenW;
     CGFloat pictureH = pictureW * self.topic.height / self.topic.width;
     if (pictureH > HCScreenH) { // 图片显示高度超过一个屏幕, 需要滚动查看
         imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
         self.scrollView.contentSize = CGSizeMake(0, pictureH);
     } else {
         imageView.size = CGSizeMake(pictureW, pictureH);
         imageView.centerY = HCScreenH * 0.5;
     }
    
    // 马上显示当前图片的下载进度
    [self.progressView setProgress:self.topic.pictureProgress animated:YES];
    
    // 下载图片
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        [self.progressView setProgress:(1.0 * receivedSize / expectedSize) animated:NO];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
}

- (IBAction)backBtnClicked {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveBtnClicked {
    if (self.imageView.image == nil) {
        [SVProgressHUD showErrorWithStatus:@"图片并没下载完毕!"];
        return;
    }
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
