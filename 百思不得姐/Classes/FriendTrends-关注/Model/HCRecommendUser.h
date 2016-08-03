//
//  HCRecommendUser.h
//  百思不得姐
//
//  Created by 成 黄 on 16/8/3.
//  Copyright © 2016年 成 黄. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCRecommendUser : NSObject

/** 所推荐的用户昵称 */
@property (copy, nonatomic) NSString *screen_name;

/** 所推荐用户的被关注量 */
@property (assign, nonatomic) NSInteger fans_count;

/** 所推荐的用户的头像url */
@property (copy, nonatomic) NSString *header;

@end
