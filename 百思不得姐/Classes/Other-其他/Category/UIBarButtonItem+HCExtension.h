//
//  UIBarButtonItem+HCExtension.h
//  百思不得姐
//
//  Created by 成 黄 on 16/8/1.
//  Copyright © 2016年 成 黄. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (HCExtension)
+ (instancetype)itemWithimage:(NSString *)image highLightedImage:(NSString *)highLightedImage target:(id)target action:(SEL)action;
@end
