//
//  NSDate+HCExtension.h
//  百思不得姐
//
//  Created by 成 黄 on 16/8/15.
//  Copyright © 2016年 成 黄. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (HCExtension)
/**
 *  比较from和self的时间差
 */
- (NSDateComponents *)deltaFrom:(NSDate *)from;
/**
 * 是否为今年
 */
- (BOOL)isThisYear;

/**
 * 是否为24小时内
 */
- (BOOL)isIn24Hour;

/**
 * 是否为昨天
 */
- (BOOL)isYesterday;
@end
