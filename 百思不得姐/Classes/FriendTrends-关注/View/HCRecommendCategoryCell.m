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
    self.backgroundColor = HCGlobalBg;
    self.selectedIndicator.backgroundColor = [UIColor redColor];
}

- (void)setCategory:(HCRecommendCategory *)category {
    _category = category;
    self.textLabel.text = category.name;
}

-(void)layoutSubviews {
    CGFloat labelX = self.selectedIndicator.width;
    CGFloat labelY = 2.0;
    CGFloat labelW = self.contentView.width - 2 * labelX;
    CGFloat labelH = self.contentView.height - 2 * labelY;
    
    self.textLabel.frame = CGRectMake(labelX, labelY, labelW, labelH);
    self.textLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectedIndicator.hidden = !selected;
    self.textLabel.textColor = selected? self.selectedIndicator.backgroundColor : HCRGBColor(78, 78, 78);
    
    // Configure the view for the selected state
}

@end
