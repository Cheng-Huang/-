//
//  HCRecommendTagCell.m
//  百思不得姐
//
//  Created by 成 黄 on 16/8/5.
//  Copyright © 2016年 成 黄. All rights reserved.
//

#import "HCRecommendTagCell.h"
#import "HCRecommendTag.h"
#import <UIImageView+WebCache.h>

@interface HCRecommendTagCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageListImageView;
@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNameLabel;
@end

@implementation HCRecommendTagCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setRecommendTag:(HCRecommendTag *)recommendTag {
    _recommendTag = recommendTag;
    [self.imageListImageView sd_setImageWithURL:[NSURL URLWithString:recommendTag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.themeNameLabel.text = recommendTag.theme_name;
//    self.subNameLabel.text = [NSString stringWithFormat:@"%zd人订阅过", recommendTag.sub_number];
    self.subNameLabel.text = (recommendTag.sub_number > 10000) ? [NSString stringWithFormat:@"%.1f万人订阅过", (recommendTag.sub_number / 10000.0)] : [NSString stringWithFormat:@"%zd人订阅过", recommendTag.sub_number];
}

- (void)setFrame:(CGRect)frame {
    frame.origin.x = 10;
    frame.size.width = frame.size.width - 2 * frame.origin.x;
    frame.size.height = frame.size.height - 1;
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
