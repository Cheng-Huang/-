//
//  HCRecommendCategory.h
//  百思不得姐
//
//  Created by 成 黄 on 16/8/3.
//  Copyright © 2016年 成 黄. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCRecommendCategory : NSObject

/** 标签id */
@property (assign, nonatomic) NSInteger id;

/** 标签名称 */
@property (copy, nonatomic) NSString *name;

/** 此标签下的用户数 */
@property (assign, nonatomic) NSInteger count;

/** 用户模型数组 */
@property (strong, nonatomic) NSMutableArray *users;

/** 一共加载了多少个推荐用户 */
@property (assign, nonatomic) NSInteger total;

/** 当前页 */
@property (assign, nonatomic) NSInteger currentPage;

@end
