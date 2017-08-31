//
//  UIColor+Fetch.h
//  DongDong
//
//  Created by yitudev166 on 16/8/24.
//  Copyright © 2016年 深圳市易图资讯股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Fetch)

/**
 *  根据number获取颜色
 *
 *  @param number 传入的number值 1 -> 25
 *
 *  @return UIColor
 */
+ (UIColor *)colorWithNumber:(NSInteger)number;

@end
