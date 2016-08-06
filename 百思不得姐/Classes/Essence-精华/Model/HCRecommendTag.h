//
//  HCRecommendTag.h
//  百思不得姐
//
//  Created by 成 黄 on 16/8/5.
//  Copyright © 2016年 成 黄. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCRecommendTag : NSObject

/** 推荐标签的图片url地址 */
@property (copy, nonatomic) NSString *image_list;

/** 标签名称 */
@property (copy, nonatomic) NSString *theme_name;

/** 此标签的订阅量 */
@property (assign, nonatomic) NSInteger sub_number;

@end
