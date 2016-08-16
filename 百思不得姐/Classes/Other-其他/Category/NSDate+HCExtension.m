//
//  NSDate+HCExtension.m
//  百思不得姐
//
//  Created by 成 黄 on 16/8/15.
//  Copyright © 2016年 成 黄. All rights reserved.
//

#import "NSDate+HCExtension.h"

@implementation NSDate (HCExtension)

- (NSDateComponents *)deltaFrom:(NSDate *)from {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        
    return [calendar components:unit fromDate:from toDate:self options:0];
}

@end
