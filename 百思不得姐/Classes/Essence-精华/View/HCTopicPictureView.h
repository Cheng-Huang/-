//
//  HCTopicPictureView.h
//  百思不得姐
//
//  Created by 成 黄 on 16/8/18.
//  Copyright © 2016年 成 黄. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HCTopic;

@interface HCTopicPictureView : UIView
+ (instancetype)pictureView;

/** 帖子数据 */
@property (nonatomic, strong) HCTopic *topic;
@end
