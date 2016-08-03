//
//  HCRecommendCategoryCell.m
//  百思不得姐
//
//  Created by 成 黄 on 16/8/3.
//  Copyright © 2016年 成 黄. All rights reserved.
//

#import "HCRecommendCategoryCell.h"
#import "HCRecommendCategory.h"

@interface HCRecommendCategoryCell ()
@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;
@end

@implementation HCRecommendCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = HCRGBColor(244, 244, 244);
    self.selectedIndicator.backgroundColor = HCRGBColor(219, 21, 26);
}

- (void)setCategory:(HCRecommendCategory *)category {
    _category = category;
    self.textLabel.text = category.name;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    // 重新调整内部textLabel的frame
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2 * self.textLabel.y;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectedIndicator.hidden = !selected;
    self.textLabel.textColor = selected? self.selectedIndicator.backgroundColor : HCRGBColor(78, 78, 78);
    
    // Configure the view for the selected state
}

@end
