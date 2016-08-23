//
//  HCTopicPictureView.m
//  百思不得姐
//
//  Created by 成 黄 on 16/8/18.
//  Copyright © 2016年 成 黄. All rights reserved.
//

#import "HCTopicPictureView.h"
#import "HCTopic.h"
#import <UIImageView+WebCache.h>
#import "HCProgressView.h"
#import "HCShowPictureViewController.h"

@interface HCTopicPictureView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
@property (weak, nonatomic) IBOutlet HCProgressView *progressView;
@end

@implementation HCTopicPictureView

+ (instancetype)pictureView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    self.autoresizingMask = UIViewAutoresizingNone;
    // 给图片添加监视器
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
}

- (void)showPicture {
    HCShowPictureViewController *pictureView = [[HCShowPictureViewController alloc] init];
    pictureView.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:pictureView animated:YES completion:nil];
}

- (void)setTopic:(HCTopic *)topic {
    _topic = topic;
    
    // 立马显示最新的进度值(防止因为网速慢, 导致显示的是其他图片的下载进度)
    [self.progressView setProgress:self.topic.pictureProgress animated:NO];
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        if (![self.topic.large_image isEqualToString:topic.large_image]) {
            return;
        }
        self.progressView.hidden = NO;
        // 计算进度值
        self.topic.pictureProgress = 1.0 * receivedSize / expectedSize;
//        HCLog(@"%@--%@--%@--%zd / %zd--%.1f%%", self.topic.name, self.topic.large_image.lastPathComponent, topic.large_image.lastPathComponent, receivedSize, expectedSize, (self.topic.pictureProgress * 100));
        // 显示进度值
        [self.progressView setProgress:self.topic.pictureProgress animated:NO];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
        // 如果是大图片, 才需要进行绘图处理
        if (topic.isBigPicture == NO) {
            return;
        }
        // 开启图形上下文
        UIGraphicsBeginImageContextWithOptions(topic.pictureF.size, YES, 0.0);
        // 将下载完的image对象绘制到图形上下文
        CGFloat width = topic.pictureF.size.width;
        CGFloat height = width * image.size.height / image.size.width;
        [image drawInRect:CGRectMake(0, 0, width, height)];
        // 获得图片
        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        // 结束图形上下文
        UIGraphicsEndImageContext();
    }];
    
    // 判断是否为gif
    NSString *extension = topic.large_image.pathExtension;
    self.gifView.hidden = ![extension.lowercaseString isEqualToString:@"gif"];
    
    // 判断是否显示"点击查看全图"
    if (topic.isBigPicture) { // 大图
        self.seeBigButton.hidden = NO;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    } else { // 非大图
        self.seeBigButton.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
    }
}

@end
