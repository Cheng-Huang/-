//
//  HCTextField.m
//  百思不得姐
//
//  Created by 成 黄 on 16/8/10.
//  Copyright © 2016年 成 黄. All rights reserved.
//

#import "HCTextField.h"
#import <objc/runtime.h>

@implementation HCTextField

/*
+ (void)initialize {
    [self getIvar];
}
*/

/**
 * runtime
 * 打印UITextField的属性名字|类型
 */

/*
+ (void)getProperties {
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([UITextField class], &count);
    for (int i = 0; i < count; i++) {
        // 取出属性
        objc_property_t property = properties[i];
        
        // 打印属性名字|类型
        HCLog(@"%s <------> %s", property_getName(property), property_getAttributes(property));
        
    }
}
*/

/**
 * runtime
 * 打印UITextField的成员变量名字|类型
 */

/*
+ (void)getIvar {
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([UITextField class], &count);
    for (int i = 0; i < count; i++) {
        // 取出成员变量
        Ivar ivar = ivars[i];
        
        // 打印成员变量名字
        HCLog(@"%s <-------> %s", ivar_getName(ivar), ivar_getTypeEncoding(ivar));
    }
}
*/

static NSString * const HCPlaceholderLabelKeyPath = @"_placeholderLabel.textColor";

- (void)awakeFromNib {
    [self resignFirstResponder];
}

- (BOOL)becomeFirstResponder {
    [self setValue:self.textColor forKeyPath:HCPlaceholderLabelKeyPath];
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder {
    [self setValue:[UIColor grayColor] forKeyPath:HCPlaceholderLabelKeyPath];
    return [super resignFirstResponder];
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
