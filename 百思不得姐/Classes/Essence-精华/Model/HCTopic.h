//
//  HCTopic.h
//  百思不得姐
//
//  Created by 成 黄 on 16/8/12.
//  Copyright © 2016年 成 黄. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCTopic : NSObject
/** 名称 */
@property (copy, nonatomic) NSString *name;
/** 头像 */
@property (copy, nonatomic) NSString *profile_image;
/** 发帖时间 */
@property (copy, nonatomic) NSString *create_time;
/** 文字内容 */
@property (copy, nonatomic) NSString *text;
/** 顶的数量 */
@property (assign, nonatomic) NSInteger ding;
/** 踩的数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发的数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论的数量 */
@property (nonatomic, assign) NSInteger comment;
@end
