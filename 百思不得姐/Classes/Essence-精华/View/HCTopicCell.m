//
//  HCTopicCell.m
//  百思不得姐
//
//  Created by 成 黄 on 16/8/14.
//  Copyright © 2016年 成 黄. All rights reserved.
//

#import "HCTopicCell.h"
#import "HCTopic.h"
#import "HCTopicPictureView.h"
#import <UIImageView+WebCache.h>

@interface HCTopicCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sinaVView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIStackView *bottomStackView;
/** 图片内容 */
@property (weak, nonatomic) HCTopicPictureView *pictureView;

@end

@implementation HCTopicCell

- (HCTopicPictureView *)pictureView {
    if (!_pictureView) {
        HCTopicPictureView *pictureView = [HCTopicPictureView pictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (void)awakeFromNib {
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}

- (void)setTopic:(HCTopic *)topic {
    _topic = topic;
    
    // 设置cell顶部控件
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.sinaVView.hidden = !topic.isSina_v;
    self.nameLabel.text = topic.name;
    self.createTimeLabel.text = topic.create_time;
    
    // 设置cell底部控件
    [self setButtonTitle:self.dingButton count:topic.ding placeholder:@"顶"];
    [self setButtonTitle:self.caiButton count:topic.cai placeholder:@"踩"];
    [self setButtonTitle:self.shareButton count:topic.repost placeholder:@"分享"];
    [self setButtonTitle:self.commentButton count:topic.comment placeholder:@"评论"];
    
    // 设置帖子的文字内容
    self.contentLabel.text = topic.text;
    // 根据模型类型(帖子类型)添加对应的内容到cell的中间
    if (topic.type == HCTopicTypePicture) { // 图片帖子
        self.pictureView.topic = topic;
        self.pictureView.frame = topic.pictureF;
    } else if (topic.type == HCTopicTypeVoice) { // 声音帖子
        //        self.voiceView.topic = topic;
        //        self.voiceView.frame = topic.voiceF;
    }
    
    [self layoutIfNeeded];
    
    
    

}

- (void)setFrame:(CGRect)frame {
    static CGFloat margin = 10;
    frame.origin.x = margin;
    frame.size.width -= 2 * margin;
    frame.size.height -= margin;
    frame.origin.y += margin;
    [super setFrame:frame];
}

/**
 * 设置按钮文字
 */
- (void)setButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder {
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
    } else if (count > 0) {
        placeholder = [NSString stringWithFormat:@"%zd", count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
}

@end
