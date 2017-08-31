//
//  UIColor+Fetch.m
//  DongDong
//
//  Created by yitudev166 on 16/8/24.
//  Copyright © 2016年 深圳市易图资讯股份有限公司. All rights reserved.
//

#import "UIColor+Fetch.h"

#define UIColorFromRGB2(r, g, b) [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1.00]

@implementation UIColor (Fetch)

/**
 *  根据number获取颜色
 *
 *  @param number 传入的number值 1 -> 17
 *
 *  @return UIColor
 */
+ (UIColor *)colorWithNumber:(NSInteger)number {
    static NSDictionary *fetchColorDict = nil;
    if (!fetchColorDict) {
        fetchColorDict = @{
            @"1": UIColorFromRGB2(254, 89, 85),
            @"2": UIColorFromRGB2(149, 149, 149),
            @"3": UIColorFromRGB2(169, 169, 169),
            @"4": UIColorFromRGB2(180, 180, 180),
            @"5": UIColorFromRGB2(109, 103, 124),
            @"6": UIColorFromRGB2(49, 49, 49),
            @"7": UIColorFromRGB2(255, 255, 255),
            @"8": UIColorFromRGB2(241, 145, 73),
            @"9": UIColorFromRGB2(19, 181, 177),
            @"10": UIColorFromRGB2(137, 87, 161),
            @"11": UIColorFromRGB2(0, 0, 0),
            @"12": UIColorFromRGB2(54, 46, 44),
            @"13": UIColorFromRGB2(238, 238, 238),
            @"14": UIColorFromRGB2(245, 81, 0),
            @"15": UIColorFromRGB2(79, 79, 79),
            @"16": UIColorFromRGB2(0, 71, 157),
            @"17": UIColorFromRGB2(243, 151, 0),
            @"18": UIColorFromRGB2(153, 153, 153),
            @"19": UIColorFromRGB2(81, 81, 81),
            @"20": UIColorFromRGB2(112, 112, 112),
            @"21": UIColorFromRGB2(20, 117, 207),
            @"22": UIColorFromRGB2(209, 214, 218),
            @"23": UIColorFromRGB2(251, 221, 200),
            @"24": UIColorFromRGB2(0, 0, 255),
            @"25": UIColorFromRGB2(229, 229, 229),
            @"26": UIColorFromRGB2(182, 192, 194),
            @"27": UIColorFromRGB2(242, 242, 242),
            @"28": UIColorFromRGB2(248, 248, 248),
            @"29": UIColorFromRGB2(204, 204, 204),
            @"30": UIColorFromRGB2(254, 203, 85),
            @"31": UIColorFromRGB2(253, 158, 28),
            @"32": UIColorFromRGB2(152, 135, 119),
            @"33": UIColorFromRGB2(30, 199, 195),
            @"34": UIColorFromRGB2(251, 206, 0),
            @"35": UIColorFromRGB2(170, 141, 28),
            @"36": UIColorFromRGB2(255, 184, 183),
            @"37": UIColorFromRGB2(115, 119, 133),
            @"38": UIColorFromRGB2(85, 153, 254)
        };
    }
    return fetchColorDict[@(number).stringValue] ?: [UIColor blackColor];
}

@end
