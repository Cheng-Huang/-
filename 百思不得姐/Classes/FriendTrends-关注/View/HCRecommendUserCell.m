//
//  HCRecommendUserCell.m
//  百思不得姐
//
//  Created by 成 黄 on 16/8/3.
//  Copyright © 2016年 成 黄. All rights reserved.
//

#import "HCRecommendUserCell.h"
#import "HCRecommendUser.h"
#import <UIImageView+WebCache.h>

@interface HCRecommendUserCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;

@end

@implementation HCRecommendUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setUser:(HCRecommendUser *)user {
    _user = user;
//    self.headerImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.user.header]]];
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:self.user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = self.user.screen_name;
    self.fansCountLabel.text = [NSString stringWithFormat:@"关注量：%zd", self.user.fans_count];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
