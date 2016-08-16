//
//  NSDate+HCExtension.m
//  百思不得姐
//
//  Created by 成 黄 on 16/8/15.
//  Copyright © 2016年 成 黄. All rights reserved.
//

#import "NSDate+HCExtension.h"

@implementation NSDate (HCExtension)

// 调试 —— 修改现在时间
/*
+ (instancetype)date {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [fmt dateFromString:@"2016-01-01 15:10:01"];
}
*/

- (NSDateComponents *)deltaFrom:(NSDate *)from {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        
    return [calendar components:unit fromDate:from toDate:self options:0];
}

- (BOOL)isThisYear {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger currentYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger givenYear = [calendar component:NSCalendarUnitYear fromDate:self];
    return currentYear == givenYear;
}

- (BOOL)isIn24Hour {
//    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
//    fmt.dateFormat = @"yyyy-MM-dd";
//    NSString *currentDate = [fmt stringFromDate:[NSDate date]];
//    NSString *givenDate = [fmt stringFromDate:self];
//    return [currentDate isEqualToString:givenDate];
    
    NSDate * dateBefore24Hour = [NSDate dateWithTimeInterval:-(24*60*60) sinceDate:[NSDate date]];
    NSDate * givenDate = self;
    NSTimeInterval delta = [givenDate timeIntervalSinceDate:dateBefore24Hour];
    return ((delta >= 0) ? true : false);
}

- (BOOL)isYesterday {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSDate *currentDate = [fmt dateFromString:[fmt stringFromDate:[NSDate date]]];
    NSDate *givenDate = [fmt dateFromString:[fmt stringFromDate:self]];
    NSCalendar *calendar = [NSCalendar currentCalendar];

    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:givenDate toDate:currentDate options:0];
    return cmps.year == 0
    && cmps.month == 0
    && cmps.day == 1;}


@end
