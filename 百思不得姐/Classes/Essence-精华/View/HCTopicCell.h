//
//  HCTopicCell.h
//  百思不得姐
//
//  Created by 成 黄 on 16/8/14.
//  Copyright © 2016年 成 黄. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HCTopic;

@interface HCTopicCell : UITableViewCell
/** 帖子数据 */
@property (strong, nonatomic) HCTopic *topic;
@end
