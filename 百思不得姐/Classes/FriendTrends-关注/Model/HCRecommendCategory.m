//
//  HCRecommendCategory.m
//  百思不得姐
//
//  Created by 成 黄 on 16/8/3.
//  Copyright © 2016年 成 黄. All rights reserved.
//

#import "HCRecommendCategory.h"

@implementation HCRecommendCategory
- (NSMutableArray *)users
{
    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
            @"ID" : @"id"
            };
}

@end
