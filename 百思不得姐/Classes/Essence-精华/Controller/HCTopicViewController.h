//
//  HCTopicViewController.h
//  百思不得姐
//
//  Created by 成 黄 on 16/8/16.
//  Copyright © 2016年 成 黄. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    HCTopicTypeAll = 1,
    HCTopicTypePicture = 10,
    HCTopicTypeWord = 29,
    HCTopicTypeVoice = 31,
    HCTopicTypeVideo = 41
} HCTopicType;

@interface HCTopicViewController : UITableViewController
/** 帖子类型(初始化时赋值) */
@property (assign, nonatomic) HCTopicType type;
@end
