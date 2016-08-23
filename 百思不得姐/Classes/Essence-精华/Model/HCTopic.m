//
//  HCTopic.m
//  百思不得姐
//
//  Created by 成 黄 on 16/8/12.
//  Copyright © 2016年 成 黄. All rights reserved.
//

#import "HCTopic.h"

@implementation HCTopic
{
    CGFloat _cellHeight;
    CGRect _pictureF;
}

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"small_image" : @"image0",
             @"large_image" : @"image1",
             @"middle_image" : @"image2"
             };
}

- (NSString *)create_time {
    // 调试 —— 自定义帖子创建时间
//    _create_time = @"2016-01-01 00:00:00";
//    _create_time = @"2015-12-31 23:58:59";
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createTime = [fmt dateFromString:_create_time];
    
    // 帖子时间｜现在时间
//    HCLog(@"%@----%@", createTime, [NSDate date]);
    /**
     * 24小时内
     *  昨天&10小时前
     *      昨天 18:56:34
     *  今天&10小时前
     *      今天 18:56:34
     *  10小时内&一小时前
     *      xx小时前
     *  1小时内
     *      xx分钟前
     *  1分钟内
     *      刚刚
     * 24小时外
     *  昨天
     *      昨天 18:56:34
     *  今年
     *      06-23 19:56:23
     *  非今年
     *      2014-05-08 18:45:30
     */
    if (createTime.isIn24Hour) { // 24小时内
        NSDateComponents *cmps = [[NSDate date] deltaFrom:createTime];
        if (cmps.hour >= 10 && createTime.isYesterday) { // 昨天 > 时间差距 >= 10小时
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:createTime];
        } else if (cmps.hour >= 10 && !createTime.isYesterday) { // 今天 > 时间差距 >= 10小时
            fmt.dateFormat = @"今天 HH:mm:ss";
            return [fmt stringFromDate:createTime];
        } else if (cmps.hour >= 1) { // 10小时 > 时间差距 >= 1小时
            return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
        } else if (cmps.minute >= 1) { // 1小时 > 时间差距 >= 1分钟
            return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
        } else { // 1分钟 > 时间差距
            return @"刚刚";
        }
    } else if (createTime.isYesterday) { // 大于24小时的昨天
        fmt.dateFormat = @"昨天 HH:mm:ss";
        return [fmt stringFromDate:createTime];
    } else if (createTime.isThisYear) { // 今年
        fmt.dateFormat = @"MM-dd HH:mm:ss";
        return [fmt stringFromDate:createTime];
    } else { // 非今年
        return _create_time;
    }
}

- (CGFloat)cellHeight {
    // 设置label每一行文字的最大宽度
    // 为了保证计算出来的数值 跟 真正显示出来的效果 一致
//    self.contentLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 4 * margin;
    
    // 文字的最大尺寸
    CGSize maxSize = CGSizeMake(HCScreenW - 4 * HCTopicCellMargin, MAXFLOAT);
    // 计算文字的高度
    CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil].size.height;
    
    _cellHeight = HCTopicCellTextY + textH + HCTopicCellMargin;
    
    // 计算cell的高度
    if (self.type == HCTopicTypePicture) {
        // 图片显示出来的宽度
        CGFloat pictureW = maxSize.width;
        // 显示显示出来的高度
        CGFloat pictureH = pictureW * self.height / self.width;
        if (pictureH >= HCTopicCellPictureMaxH) { // 图片高度过长
            pictureH = HCTopicCellPictureBreakH;
            self.bigPicture = YES; // 大图
        }
        // 计算图片控件的frame
        CGFloat pictureX = HCTopicCellMargin;
        CGFloat pictureY = HCTopicCellTextY + textH + HCTopicCellMargin;
        _pictureF = CGRectMake(pictureX, pictureY, pictureW, pictureH);
        _cellHeight += pictureH + HCTopicCellMargin;
    } else if (self.type == HCTopicTypeVoice) {

    }
    // 底部工具条的高度
    _cellHeight += HCTopicCellBottomBarH + HCTopicCellMargin;
    return _cellHeight;
}

@end

