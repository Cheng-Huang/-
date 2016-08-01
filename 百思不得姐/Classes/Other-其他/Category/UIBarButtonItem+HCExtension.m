//
//  UIBarButtonItem+HCExtension.m
//  百思不得姐
//
//  Created by 成 黄 on 16/8/1.
//  Copyright © 2016年 成 黄. All rights reserved.
//

#import "UIBarButtonItem+HCExtension.h"

@implementation UIBarButtonItem (HCExtension)

+ (instancetype)itemWithimage:(NSString *)image highLightedImage:(NSString *)highLightedImage target:(id)target action:(SEL)action {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highLightedImage] forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.size = btn.currentBackgroundImage.size;
    return [[self alloc] initWithCustomView:btn];
}
@end
